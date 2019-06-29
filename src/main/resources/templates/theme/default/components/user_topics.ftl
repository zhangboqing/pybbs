<#macro user_topics pageNo pageSize username isPaginate=false isFooter=false>
  <div class="card">
      <@tag_user_topics username=username pageNo=pageNo pageSize=pageSize>
        <div class="card-header">${username}${i18n.getMessage("theme.default.components.user_topics.1")}</div>
          <#if topics.total == 0>
            <div class="card-body">
              ${i18n.getMessage("theme.default.components.user_topics.2")}
            </div>
          <#else>
            <div class="card-body paginate-bot">
                <#list topics.records as topic>
                  <div class="media">
                    <div class="media-body">
                      <div class="title">
                        <a href="/topic/${topic.id}">
                            ${topic.title!?html}
                        </a>
                      </div>
                      <div>
                        <span><a href="/user/${topic.username}">${topic.username}</a></span>
                        <span class="hidden-sm hidden-xs">•</span>
                        <span class="hidden-sm hidden-xs"><a
                              href="/topic/${topic.id}">${topic.commentCount}${i18n.getMessage("theme.default.components.user_topics.3")}</a></span>
                        <span class="hidden-sm hidden-xs">•</span>
                        <span class="hidden-sm hidden-xs">${topic.view}${i18n.getMessage("theme.default.components.user_topics.4")}</span>
                        <span>•</span>
                        <span>${model.formatDate(topic.inTime)}</span>
                      </div>
                    </div>
                  </div>
                    <#if topic_has_next>
                      <div class="divide mt-2 mb-2"></div>
                    </#if>
                </#list>
                <#if isPaginate>
                    <#include "paginate.ftl"/>
                    <@paginate currentPage=topics.current totalPage=topics.pages actionUrl="/user/${username}/topics" urlParas=""/>
                </#if>
            </div>
              <#if isFooter>
                <div class="card-footer">
                  <a href="/user/${username}/topics">${username}${i18n.getMessage("theme.default.components.user_topics.5")}&gt;&gt;</a>
                </div>
              </#if>
          </#if>
      </@tag_user_topics>
  </div>
</#macro>
