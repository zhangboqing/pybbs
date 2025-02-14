package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.exception.ApiAssert;
import co.yiiu.pybbs.model.Comment;
import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.ICommentService;
import co.yiiu.pybbs.service.ITopicService;
import co.yiiu.pybbs.util.Result;
import co.yiiu.pybbs.util.SensitiveWordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@RestController
@RequestMapping("/api/comment")
public class CommentApiController extends BaseApiController {

  @Autowired
  private ICommentService commentService;
  @Autowired
  private ITopicService topicService;

  // 创建评论
  @PostMapping
  public Result create(@RequestBody Map<String, String> body, HttpSession session) {
    User user = getApiUser();
    ApiAssert.isTrue(user.getActive(), "你的帐号还没有激活，请去个人设置页面激活帐号");
    String content = body.get("content");
    Integer topicId = StringUtils.isEmpty(body.get("topicId")) ? null : Integer.parseInt(body.get("topicId"));
    Integer commentId = StringUtils.isEmpty(body.get("commentId")) ? null : Integer.parseInt(body.get("commentId"));
    ApiAssert.notEmpty(content, "请输入评论内容");
    ApiAssert.notNull(topicId, "话题ID呢？");
    Topic topic = topicService.selectById(topicId);
    ApiAssert.notNull(topic, "你晚了一步，话题可能已经被删除了");
    // 组装comment对象
    Comment comment = new Comment();
    comment.setCommentId(commentId);
    comment.setContent(content);
    comment.setInTime(new Date());
    comment.setTopicId(topic.getId());
    comment.setUserId(user.getId());
    comment = commentService.insert(comment, topic, user, session);
    // 过滤评论内容
    comment.setContent(SensitiveWordUtil.replaceSensitiveWord(comment.getContent(), "*", SensitiveWordUtil
        .MinMatchType));
    return success(comment);
  }

  // 更新评论
  // 更新操作不用判断用户是否激活过，如果没有激活的用户是没有办法评论的，所以更新操作不做帐号是否激活判断
  @PutMapping("/{id}")
  public Result update(@PathVariable Integer id, @RequestBody Map<String, String> body) {
    User user = getApiUser();
    String content = body.get("content");
    ApiAssert.notNull(id, "评论ID呢？");
    ApiAssert.notEmpty(content, "请输入评论内容");
    Comment comment = commentService.selectById(id);
    ApiAssert.notNull(comment, "这个评论可能已经被删除了，多发点对别人有帮助的评论吧");
    ApiAssert.isTrue(comment.getUserId().equals(user.getId()), "请给你的权限让你编辑别人的评论？");
    comment.setContent(content);
    commentService.update(comment);
    comment.setContent(SensitiveWordUtil.replaceSensitiveWord(comment.getContent(), "*", SensitiveWordUtil
        .MinMatchType));
    return success(comment);
  }

  // 删除评论
  @DeleteMapping("/{id}")
  public Result delete(@PathVariable Integer id, HttpSession session) {
    User user = getApiUser();
    Comment comment = commentService.selectById(id);
    ApiAssert.notNull(comment, "这个评论可能已经被删除了，多发点对别人有帮助的评论吧");
    ApiAssert.isTrue(comment.getUserId().equals(user.getId()), "请给你的权限让你删除别人的评论？");
    commentService.delete(comment, session);
    return success();
  }

  // 点赞评论
  @GetMapping("/{id}/vote")
  public Result vote(@PathVariable Integer id, HttpSession session) {
    User user = getApiUser();
    Comment comment = commentService.selectById(id);
    ApiAssert.notNull(comment, "这个评论可能已经被删除了");
    ApiAssert.notTrue(comment.getUserId().equals(user.getId()), "给自己评论点赞，脸皮真厚！！");
    int voteCount = commentService.vote(comment, user, session);
    return success(voteCount);
  }
}
