<#include "../layout/layout.ftl"/>
<@html page_title="${i18n.getMessage('theme.default.tag.tag.4')}" page_tab="">
  <div class="row">
    <div class="col-md-9">
      <div class="card">
        <div class="card-body">
          <h4 style="margin-top: 0; margin-bottom: 10px;">
              <#if tag.icon??>
                <img src="${tag.icon}" width="32" alt="">
              </#if>
              ${tag.name}
            <small>${i18n.getMessage("theme.default.tag.tag.1")}${tag.topicCount!0}${i18n.getMessage("theme.default.tag.tag.2")}</small>
              <#if _user??>
                <a href="/topic/create?tag=${tag.name}" class="btn btn-sm btn-info pull-right">${i18n.getMessage("theme.default.tag.tag.3")}</a>
              </#if>
          </h4>
          <small>${tag.description!}</small>
          <span></span>
        </div>
        <div class="divide"></div>
        <div class="card-body paginate-bot">
            <#include "../components/topics.ftl"/>
            <@topics page=page tags=false/>

            <#include "../components/paginate.ftl"/>
            <@paginate currentPage=page.current totalPage=page.pages actionUrl="/topic/tag/${tag.name}"/>
        </div>
      </div>
    </div>
    <div class="col-md-3 hidden-xs">
        <#if _user??>
            <#include "../components/user_info.ftl"/>
        <#else>
            <#include "../components/welcome.ftl"/>
        </#if>
    </div>
  </div>
</@html>
