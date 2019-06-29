<#macro user_comments pageNo pageSize username isPaginate=false isFooter=false>
  <div class="card">
      <@tag_user_comments username=username pageNo=pageNo pageSize=pageSize>
        <div class="card-header">${username} ${i18n.getMessage("theme.default.components.user_comments.1")}</div>
          <#if comments.total == 0>
            <div class="card-body">
              ${i18n.getMessage("theme.default.components.user_comments.2")}
            </div>
          <#else>
            <table class="table table-striped">
                <#list comments.records as comment>
                  <tr>
                    <td>
                      <a href="/user/${comment.commentUsername}">${comment.commentUsername}</a>
                        ${model.formatDate(comment.inTime)!}
                      ${i18n.getMessage("theme.default.components.user_comments.3")}
                      <a href="/user/${comment.topicUsername}">${comment.topicUsername}</a>
                      ${i18n.getMessage("theme.default.components.user_comments.4")} › <a href="/topic/${comment.topicId}">${comment.title!?html}</a>
                    </td>
                  </tr>
                  <tr class="user_comments">
                    <td>
                        ${model.formatContent(comment.content)}
                    </td>
                  </tr>
                </#list>
            </table>
              <#if isPaginate>
                <div class="card-body" style="padding: 0 15px;">
                    <#include "paginate.ftl"/>
                    <@paginate currentPage=comments.current totalPage=comments.pages actionUrl="/user/${username}/comments" urlParas=""/>
                </div>
              </#if>
              <#if isFooter>
                <div class="card-footer">
                  <a href="/user/${username}/comments">${username}${i18n.getMessage("theme.default.components.user_comments.5")}&gt;&gt;</a>
                </div>
              </#if>
          </#if>
      </@tag_user_comments>
  </div>
</#macro>
