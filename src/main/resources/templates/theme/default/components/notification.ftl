<#macro notification userId read limit>
    <@tag_notifications userId=userId read=read limit=limit>
        <#list notifications as notification>
          <div class="media notification_${read}">
            <img src="${notification.avatar!}" class="mr-3 avatar avatar-sm">
            <div class="media-body">
              <div class="gray" <#if !notification.read>style="font-weight:700;"</#if>>
                <a href="/user/${notification.username}">${notification.username}</a>
                <span>${model.formatDate(notification.inTime)}</span>
                  <#if notification.action == "COMMENT">
                    ${i18n.getMessage("theme.default.components.notification.ftl.1")} <a href="/topic/${notification.topicId}">${notification.title}</a>
                  <#elseif notification.action == "REPLY">
                    ${i18n.getMessage("theme.default.components.notification.ftl.2")} <a href="/topic/${notification.topicId}">${notification.title}</a> ${i18n.getMessage("theme.default.components.notification.ftl.3")}
                  <#elseif notification.action == "COLLECT">
                    ${i18n.getMessage("theme.default.components.notification.ftl.4")} <a href="/topic/${notification.topicId}">${notification.title}</a>
                  </#if>
              </div>
                <#if notification.content??>
                  <div class="payload">
                      ${model.formatContent(notification.content)}
                  </div>
                </#if>
            </div>
          </div>
            <#if notification_has_next>
              <div class="divide"></div>
            </#if>
        </#list>
    </@tag_notifications>
</#macro>
