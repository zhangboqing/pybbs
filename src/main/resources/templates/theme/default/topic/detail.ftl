<#include "../layout/layout.ftl"/>
<@html page_title=topic.title page_tab="">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css">
  <div class="row">
    <div class="col-md-9">
      <div class="card">
        <div class="card-body topic-detail-header">
          <div class="media">
            <div class="media-body">
              <h2 class="topic-detail-title">
                  ${topic.title!?html}
              </h2>
              <p class="gray">
                  <#if _user??>
                    <i id="vote_topic_icon_${topic.id}" style="font-size: 18px;"
                       class="fa <#if model.getUpIds(topic.upIds)?seq_contains('${_user.id}')> fa-thumbs-up <#else> fa-thumbs-o-up </#if>"
                       onclick="voteTopic('${topic.id}')"></i>
                  <#else>
                    <i id="vote_topic_icon_${topic.id}" style="font-size: 18px;" class="fa fa-thumbs-o-up"
                       onclick="voteTopic('${topic.id}')"></i>
                  </#if>
                <span id="vote_topic_count_${topic.id}">${model.getUpIds(topic.upIds)?size}</span>
                <span>•</span>
                  <#if topic.top == true>
                    <span class="badge badge-info">${i18n.getMessage("theme.default.topic.detail.1")}</span>
                    <span>•</span>
                  <#elseif topic.good == true>
                    <span class="badge badge-info">${i18n.getMessage("theme.default.topic.detail.2")}</span>
                    <span>•</span>
                  </#if>
                <span><a href="/user/${topicUser.username!}">${topicUser.username!}</a></span>
                <span>•</span>
                <span>${model.formatDate(topic.inTime)}</span>
                <span>•</span>
                <span>${topic.view!1}${i18n.getMessage("theme.default.topic.detail.3")}</span>
                  <#if _user?? && topic.userId == _user.id>
                    <span>•</span>
                    <span><a href="/topic/edit/${topic.id}">${i18n.getMessage("theme.default.topic.detail.4")}</a></span>
                    <span>•</span>
                    <span><a href="javascript:;" id="deleteTopic">${i18n.getMessage("theme.default.topic.detail.5")}</a></span>
                  </#if>
              </p>
            </div>
            <div class="media-right">
              <img src="${topicUser.avatar!}" class="avatar avatar-lg"/>
            </div>
          </div>
        </div>
        <div class="divide"></div>
        <div class="card-body topic-detail-content">
            ${model.formatContent(topic.content)}
          <div>
              <#list tags as tag>
                <a href="/topic/tag/${tag.name}"><span class="badge badge-info">${tag.name}</span></a>
              </#list>
          </div>
        </div>
          <#if _user??>
            <div class="card-footer">
              <a href="javascript:window.open('http://service.weibo.com/share/share.php?url=${site.base_url!}/topic/${topic.id}?r=${_user.username!}&title=${topic.title!?html}', '_blank', 'width=550,height=370'); recordOutboundLink(this, 'Share', 'weibo.com');">${i18n.getMessage("theme.default.topic.detail.6")}</a>&nbsp;
                <#if collect??>
                  <a href="javascript:;" class="collectTopic">${i18n.getMessage("theme.default.topic.detail.7")}</a>
                <#else>
                  <a href="javascript:;" class="collectTopic">${i18n.getMessage("theme.default.topic.detail.8")}</a>
                </#if>
              <span class="pull-right"><span id="collectCount">${collects?size}</span>${i18n.getMessage("theme.default.topic.detail.9")}</span>
            </div>
          </#if>
      </div>

        <#--评论列表-->
        <#include "../components/topic_comments.ftl"/>
        <@topic_comments topicId=topic.id />

        <#if _user??>
          <div class="card">
            <div class="card-header">
              ${i18n.getMessage("theme.default.topic.detail.10")}
              <span class="pull-right">
            <a href="javascript:;" id="uploadImageBtn">${i18n.getMessage("theme.default.topic.detail.11")}</a>&nbsp;|
            <a href="javascript:;" id="goTop">${i18n.getMessage("theme.default.topic.detail.12")}</a>
          </span>
            </div>
            <input type="hidden" name="commentId" id="commentId" value=""/>
            <textarea name="content" id="content" class="form-control" placeholder="添加一条评论，支持Markdown语法"></textarea>
            <div class="card-body">
              <button id="comment_btn" class="btn btn-sm btn-info">
                <span class="glyphicon glyphicon-send"></span> ${i18n.getMessage("theme.default.topic.detail.13")}
              </button>
            </div>
          </div>
          <link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/codemirror.min.css" rel="stylesheet">
          <script src="/static/theme/default/js/codemirror.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/mode/markdown/markdown.min.js"></script>
          <script
              src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/addon/display/placeholder.min.js"></script>
          <style>
            .CodeMirror {
              border-top: 0;
              height: 150px;
            }
          </style>
        </#if>
    </div>
    <div class="col-md-3 d-none d-md-block">
        <#include "../components/author.ftl"/>
        <#include "../components/other_topic.ftl"/>
        <@other_topic userId=topic.userId topicId=topic.id limit=7/>
    </div>
  </div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
  <script>
    <#if _user??>
    $(function () {
      hljs.initHighlightingOnLoad();
      CodeMirror.keyMap.default["Shift-Tab"] = "indentLess";
      CodeMirror.keyMap.default["Tab"] = "indentMore";
      window.editor = CodeMirror.fromTextArea(document.getElementById("content"), {
        lineNumbers: true,     // 显示行数
        indentUnit: 4,         // 缩进单位为4
        tabSize: 4,
        matchBrackets: true,   // 括号匹配
        mode: 'markdown',     // Markdown模式
        lineWrapping: true,    // 自动换行
      });

      $("#comment_btn").click(function () {
        var content = window.editor.getDoc().getValue();
        if (!content) {
          err("请输入评论内容");
          return;
        }
        var _this = this;
        $(_this).button("loading");
        $.ajax({
          url: '/api/comment',
          type: 'post',
          cache: false,
          async: false,
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify({
            topicId: '${topic.id}',
            content: content,
            commentId: $("#commentId").val(),
          }),
          headers: {
            'token': '${_user.token}'
          },
          success: function (data) {
            if (data.code === 200) {
              suc("评论成功");
              setTimeout(function () {
                window.location.reload();
              }, 700);
            } else {
              err(data.description);
              $(_this).button("reset");
            }
          }
        })
      })

      $(".collectTopic").click(function () {
        var _this = this;
        var text = $(_this).text();
        var collectCount = $("#collectCount").text();
        var type = '';
        if (text === "加入收藏") {
          type = 'post';
        } else if (text === "取消收藏") {
          type = 'delete';
        }
        $.ajax({
          url: '/api/collect/${topic.id}',
          type: type,
          cache: false,
          async: false,
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            "token": "${_user.token}",
          },
          success: function (data) {
            if (data.code === 200) {
              if (text === "加入收藏") {
                suc("收藏成功");
                $(_this).text("取消收藏");
                $("#collectCount").text(parseInt(collectCount) + 1);
              } else if (text === "取消收藏") {
                suc("取消收藏成功");
                $(_this).text("加入收藏");
                $("#collectCount").text(parseInt(collectCount) - 1);
              }
            } else {
              err(data.description);
            }
          }
        })
      });
      // 删除话题
      $("#deleteTopic").click(function () {
        if (confirm("确定要删除吗？这会清空跟这个话题所有相关的数据，再考虑考虑呗！！")) {
          $.ajax({
            url: '/api/topic/${topic.id}',
            type: 'delete',
            cache: false,
            async: false,
            dataType: 'json',
            contentType: 'application/json',
            headers: {
              'token': '${_user.token}'
            },
            data: JSON.stringify({token: '${_user.token}'}),
            success: function (data) {
              if (data.code === 200) {
                suc("删除成功");
                setTimeout(function () {
                  window.location.href = "/";
                }, 700);
              } else {
                err(data.description);
              }
            }
          })
        }
      });
    });

    // 点赞话题
    function voteTopic(id) {
      $.ajax({
        url: '/api/topic/' + id + '/vote',
        type: 'get',
        cache: false,
        async: false,
        contentType: 'application/json',
        dataType: 'json',
        headers: {
          'token': '${_user.token}'
        },
        success: function (data) {
          if (data.code === 200) {
            var voteTopicIcon = $("#vote_topic_icon_" + id);
            if (voteTopicIcon.hasClass("fa-thumbs-up")) {
              suc("取消点赞成功");
              voteTopicIcon.removeClass("fa-thumbs-up");
              voteTopicIcon.addClass("fa-thumbs-o-up");
            } else {
              suc("点赞成功");
              voteTopicIcon.addClass("fa-thumbs-up");
              voteTopicIcon.removeClass("fa-thumbs-o-up");
            }
            $("#vote_topic_count_" + id).text(data.detail);
          } else {
            err(data.description);
          }
        }
      })
    }

    // 删除评论
    function deleteComment(id) {
      if (confirm("确定要删除这个评论吗？删了就没有了哦！")) {
        $.ajax({
          url: '/api/comment/' + id,
          cache: false,
          async: false,
          type: 'delete',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          success: function (data) {
            if (data.code === 200) {
              suc("删除成功");
              setTimeout(function () {
                window.location.reload();
              }, 700);
            } else {
              err(data.description);
            }
          }
        })
      }
    }

    // 回复评论
    function commentThis(username, commentId) {
      $("#commentId").val(commentId);
      var oldContent = window.editor.getDoc().getValue();
      if (oldContent) oldContent += '\n';
      window.editor.getDoc().setValue(oldContent + "@" + username + " ");
      window.editor.focus();
      //定位到文档的最后一个字符的位置
      window.editor.setCursor(window.editor.lineCount(), 0);
    }

    </#if>

    $("#goTop").click(function () {
      $('html, body').animate({scrollTop: 0}, 500);
    })
  </script>
    <#if _user??>
        <#include "../components/upload.ftl"/>
    </#if>
</@html>
