<#include "../layout/layout.ftl"/>
<@html page_title="${username} ${i18n.getMessage('theme.default.user.collects.3')}" page_tab="">
  <div class="row">
    <div class="col-md-9">
      <div class="card">
        <div class="card-header">${username} ${i18n.getMessage("theme.default.user.collects.1")}</div>
        <div class="card-body">
            <@tag_user_collects pageNo=pageNo pageSize=site.page_size username=username>
                <#if collects.total == 0>
                  ${i18n.getMessage("theme.default.user.collects.2")}
                <#else>
                    <#include "../components/topics.ftl"/>
                    <@topics page=collects/>
                </#if>
            </@tag_user_collects>
        </div>
      </div>
    </div>
    <div class="col-md-3 hidden-xs">
        <#if _user??>
            <#include "../components/user_info.ftl"/>
        <#else>
            <#include "../components/welcome.ftl"/>
        </#if>
        <#include "../components/score.ftl"/>
        <@score limit=10/>
    </div>
  </div>
</@html>
