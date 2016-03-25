package com.jfinalbbs.module.topic;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinalbbs.common.BaseModel;
import com.jfinalbbs.module.section.Section;
import com.jfinalbbs.utils.DateUtil;

import java.util.Date;
import java.util.List;

/**
 * Created by Tomoya.
 * Copyright (c) 2016, All Rights Reserved.
 * http://jfinalbbs.com
 */
public class Topic extends BaseModel<Topic> {

    public static final Topic me = new Topic();

    // --------------- 前台查询方法 开始 --------------
    public Topic findById(String id) {
        return super.findFirst("select * from jfbbs_topic where isdelete = 0 and id = ?", id);
    }

    public Page<Topic> paginate(int pageNumber, int pageSize, String tab, String q, Integer show_status, Integer l) {
        String select = "select s.tab, s.name as sectionName, t.*, " +
                "(select u.avatar from jfbbs_user u where u.id = t.last_reply_author_id) as last_reply_author_avatar, " +
                "(select u.avatar from jfbbs_user u where u.id = t.author_id) as avatar, " +
                "(select u.nickname from jfbbs_user u where u.id = t.author_id) as nickname ";
        String orderBy = " order by t.top desc, t.last_reply_time desc ";
        StringBuffer condition = new StringBuffer();
        if (l == null || l == 0) {
            condition.append(" from jfbbs_topic t left join jfbbs_section s on t.s_id = s.id where 1 = 1 and t.isdelete = 0 ");
        } else {
            condition.append(" from jfbbs_topic t left join jfbbs_section s on t.s_id = s.id ")
                    .append(" left join jfbbs_label_topic_id lti on t.id = lti.tid ")
                    .append(" left join jfbbs_label l on l.id = lti.lid ")
                    .append(" where 1 = 1 and t.isdelete = 0 and l.id = ").append(l);
        }
        if (show_status != null) {
            condition.append(" and t.show_status = " + show_status);
        }
        if (!StrKit.isBlank(tab) && tab.equals("good")) {
            condition.append(" and t.good = 1 ");
        } else if (!StrKit.isBlank(tab) && tab.equals("noreply")) {
            condition.append(" and t.id not in (select tid from jfbbs_reply) ");
        }
        if (!StrKit.isBlank(tab) && (tab.equals("all") || tab.equals("good") || tab.equals("noreply"))) {
            tab = null;
        }
        if (!StrKit.isBlank(tab)) {
            condition.append(" and s.tab = '" + tab + "'");
        }
        if (!StrKit.isBlank(q)) {
            q = q.replace("\"", "");
            String[] qs = q.split(" ");
            condition.append(" and (");
            for (int c = 0; c < qs.length; c++) {
                condition.append("t.title like \"%" + qs[c] + "%\" or t.content like \"%" + qs[c] + "%\" ");
                if (c + 1 < qs.length) condition.append(" or ");
            }
            condition.append(" ) ");
        }
        List<Section> sections = Section.me.findShow();
        if (sections.size() > 0) {
            String sid = "";
            for (Section s : sections) {
                sid += s.get("id") + ",";
            }
            condition.append(" and t.s_id in (" + sid.substring(0, sid.length() - 1) + ") ");
        }
        return super.paginate(pageNumber, pageSize, select, condition + orderBy);
    }

    public Topic findByIdWithUser(String id) {
        List<Topic> topics = find(
                "select t.*, s.name as sectionName, s.tab, u.nickname, u.avatar, u.score, u.signature " +
                        " from jfbbs_topic t left join jfbbs_user u on t.author_id = u.id " +
                        " left join jfbbs_section s on s.id = t.s_id " +
                        "where t.isdelete = 0 and t.id = ?", id);
        if (topics.size() > 0) {
            Topic topic = topics.get(0);
            topic.set("view", topic.getInt("view") + 1).update();
            //view+1
            return topic;
        }
        return null;
    }

    //查询作者其他话题，不包含传入的id
    public List<Topic> findByAuthorIdNotTid(String authorId, String tid, int size) {
        return super.find("select * from jfbbs_topic where isdelete = 0 and id <> ? and author_id = ? order by in_time desc limit 0, ?;", tid, authorId, size);
    }

    //查询无人回复的话题
    public List<Topic> findNotReply(int size) {
        return super.find("select * from jfbbs_topic t where t.isdelete = 0 and t.id not in (select tid from jfbbs_reply) order by in_time desc limit 0, ?;", size);
    }

    public Page<Topic> paginateByAuthorId(int pageNumber, int pageSize, String authorId) {
        return super.paginate(pageNumber, pageSize,
                "select t.*, (select s.tab from jfbbs_section s where s.id = t.s_id) as tab, " +
                        "(select u.avatar from jfbbs_user u where u.id = t.last_reply_author_id) as last_reply_author_avatar, " +
                        "(select s.name from jfbbs_section s where s.id = t.s_id) as sectionName, " +
                        "(select u.avatar from jfbbs_user u where u.id = t.author_id) as avatar",
                "from jfbbs_topic t where t.isdelete = 0 and t.author_id = ? order by in_time desc", authorId);
    }

    public Topic findWithSection(String id) {
        return super.findFirst("select t.*, s.name as sectionName, s.tab from jfbbs_topic t left join jfbbs_section s on t.s_id = s.id where t.isdelete = 0 and t.id = ?", id);
    }

    //查询我回复的话题
    public Page<Topic> paginateMyReplyTopics(int pageNumber, int pageSize, String authorId) {
        return super.paginate(pageNumber, pageSize, "select t.*, " +
                        "(select u.avatar from jfbbs_user u where u.id = t.author_id) as avatar, " +
                        "(select u.avatar from jfbbs_user u where u.id = t.last_reply_author_id) as last_reply_author_avatar, " +
                        "(select s.name from jfbbs_section s where s.id = t.s_id) as sectionName ",
                "from jfbbs_reply r left join jfbbs_topic t on t.id = r.tid where t.isdelete = 0 and r.author_id = ? group by r.id order by r.in_time desc", authorId);
    }

    //查询话题总数
    public int topicCount() {
        return super.find("select id from jfbbs_topic where isdelete = 0").size();
    }
    // --------------- 前台查询方法 结束 --------------


    // --------------- 后台查询方法 开始 --------------
    public Page<Topic> page(int pageNumber, int pageSize) {
        return super.paginate(pageNumber, pageSize,
                "select t.*, s.name as sectionName, s.tab, u.nickname ",
                "from jfbbs_topic t left join jfbbs_section s on t.s_id = s.id " +
                        "left join jfbbs_user u on t.author_id = u.id where t.isdelete = 0 order by t.top desc, t.in_time desc");
    }

    public List<Topic> findToday() {
        String start = DateUtil.formatDate(new Date()) + " 00:00:00";
        String end = DateUtil.formatDate(new Date()) + " 23:59:59";
        return super.find("select id, title, in_time from jfbbs_topic where isdelete = 0 and in_time between ? and ? order by in_time desc", start, end);
    }

}
