package co.yiiu.pybbs.service;

import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.util.MyPage;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
public interface ITopicService {
  // 分页查询话题
  MyPage<Map<String, Object>> selectAll(Integer pageNo, String tab);

  // 查询话题作者其它的话题
  List<Topic> selectAuthorOtherTopic(Integer userId, Integer topicId, Integer limit);

  // 查询用户的话题
  MyPage<Map<String, Object>> selectByUserId(Integer userId, Integer pageNo, Integer pageSize);

  // 保存话题
  Topic insert(String title, String content, String tags, User user, HttpSession session);

  // 根据id查询话题
  Topic selectById(Integer id);

  // 根据title查询话题，防止重复话题
  Topic selectByTitle(String title);

  // 处理话题的访问量
  Topic updateViewCount(Topic topic, String ip);

  // 更新话题
  void update(Topic topic, String tags);

  // 删除话题
  void delete(Topic topic, HttpSession session);

  // 根据用户id删除帖子
  void deleteByUserId(Integer userId);

  // 索引全部话题
  void indexAllTopic();

  // 索引话题
  void indexTopic(String id, String title, String content);

  // 删除话题索引
  void deleteTopicIndex(String id);

  // 删除所有话题索引
  void deleteAllTopicIndex();

  MyPage<Map<String, Object>> selectAllForAdmin(Integer pageNo, String startDate, String endDate, String username);

  // 查询今天新增的话题数
  int countToday();

  int vote(Topic topic, User user, HttpSession session);
}
