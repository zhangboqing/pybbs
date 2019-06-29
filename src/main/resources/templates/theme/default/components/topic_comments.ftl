<#macro topic_comments topicId>
    <@tag_topic_comments topicId=topicId>
        <#if comments?size == 0>
          <div class="nocomment-tip">${i18n.getMessage("theme.default.components.topic_comments.1")}</div>
        <#else>
          <div class="card">
            <div class="card-header">${i18n.getMessage("theme.default.components.topic_comments.2")} ${comments?size} ${i18n.getMessage("theme.default.components.topic_comments.3")}</div>
            <div class="card-body">
                <#list comments as comment>
                  <div class="media" id="comment${comment.id}" style="padding-left: ${comment.layer * 30}px;">
                    <div class="media-body">
                      <div class="gray d-flex justify-content-between">
                        <div>
                          <a href="/user/${comment.username}">
                            <img src="${comment.avatar!}" class="avatar avatar-sm" alt=""/>
                          </a>
                          <a href="/user/${comment.username!}">${comment.username!} </a>
                            <#if topicUser?? && topicUser.id == comment.userId>
                              <span class="text-success">[${i18n.getMessage("theme.default.components.topic_comments.4")}]</span>
                            </#if>
                            ${model.formatDate(comment.inTime)}
                        </div>
                        <div>
                            <#if _user??>
                              <i id="vote_icon_${comment.id}" class="fa
                                              <#if model.getUpIds(comment.upIds)?seq_contains('${_user.id}')> fa-thumbs-up <#else> fa-thumbs-o-up </#if>"
                                 onclick="vote('${comment.id}')"></i>
                            <#else>
                              <i id="vote_icon_${comment.id}" class="fa fa-thumbs-o-up"
                                 onclick="vote('${comment.id}')"></i>
                            </#if>
                          <span id="vote_count_${comment.id}">${model.getUpIds(comment.upIds)?size}</span>&nbsp;
                            <#if _user??>
                                <#if _user.id == comment.userId>
                                  <a href="/comment/edit/${comment.id}"><span
                                        class="glyphicon glyphicon-edit"></span></a>
                                  <a href="javascript:;" onclick="deleteComment(${comment.id})">
                                    <span class="glyphicon glyphicon-trash"></span>
                                  </a>
                                </#if>
                              <i class="fa fa-reply" onclick="commentThis('${comment.username}', '${comment.id}')"></i>
                            </#if>
                        </div>
                      </div>
                      <div class="comment-detail-content ml-4 mt-2">${model.formatContent(comment.content)}</div>
                    </div>
                  </div>
                    <#if comment?has_next>
                      <div class="divide"></div>
                    </#if>
                </#list>
                <#if _user??>
                  <script>
                    function vote(id) {
                      $.ajax({
                        url: '/api/comment/' + id + '/vote',
                        cache: false,
                        async: false,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json',
                        headers: {
                          'token': '${_user.token}'
                        },
                        success: function (data) {
                          if (data.code === 200) {
                            var voteIcon = $("#vote_icon_" + id);
                            if (voteIcon.hasClass("fa-thumbs-up")) {
                              suc("${i18n.getMessage('theme.default.components.topic_comments.5')}");
                              voteIcon.removeClass("fa-thumbs-up");
                              voteIcon.addClass("fa-thumbs-o-up");
                            } else {
                              suc("${i18n.getMessage('theme.default.components.topic_comments.6')}");
                              voteIcon.addClass("fa-thumbs-up");
                              voteIcon.removeClass("fa-thumbs-o-up");
                            }
                            $("#vote_count_" + id).text(data.detail);
                          } else {
                            err(data.description);
                          }
                        }
                      })
                    }
                  </script>
                </#if>
            </div>
          </div>
        </#if>
    </@tag_topic_comments>
</#macro>
