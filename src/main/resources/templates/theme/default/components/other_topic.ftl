<#macro other_topic userId topicId limit>
  <div class="card">
    <div class="card-header">${i18n.getMessage("theme.default.components.other_topic.1")}</div>
    <table class="table">
        <@tag_other_topic userId=userId topicId=topicId limit=limit>
            <#list topics as topic>
              <tr>
                <td><a href="/topic/${topic.id}">${topic.title}</a></td>
              </tr>
            </#list>
        </@tag_other_topic>
    </table>
  </div>
</#macro>
