<#include "layout/layout.ftl"/>
<@html page_title="${i18n.getMessage('theme.default.index.6')}" page_tab="index">
    <#if active?? && active>
      <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
              aria-hidden="true">&times;</span></button>
        <strong>${i18n.getMessage("theme.default.index.7")}</strong>
      </div>
    </#if>
  <div class="row">
    <div class="col-md-9">
      <div class="card">
        <div class="card-header">
          <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link <#if tab=="all">active</#if>" href="/?tab=all">${i18n.getMessage("theme.default.index.1")}</a></li>
            <li class="nav-item"><a class="nav-link <#if tab=="good">active</#if>" href="/?tab=good">${i18n.getMessage("theme.default.index.2")}</a>
            </li>
            <li class="nav-item"><a class="nav-link <#if tab=="hot">active</#if>" href="/?tab=hot">${i18n.getMessage("theme.default.index.3")}</a></li>
            <li class="nav-item"><a class="nav-link <#if tab=="newest">active</#if>" href="/?tab=newest">${i18n.getMessage("theme.default.index.4")}</a>
            </li>
            <li class="nav-item"><a class="nav-link <#if tab=="noanswer">active</#if>"
                                    href="/?tab=noanswer">${i18n.getMessage("theme.default.index.5")}</a>
            </li>
          </ul>
        </div>
        <div class="card-body">
            <@tag_topics pageNo=pageNo!1 tab=tab!"all">
                <#include "components/topics.ftl"/>
                <@topics page=page/>

                <#include "components/paginate.ftl"/>
                <@paginate currentPage=page.current totalPage=page.pages actionUrl="/" urlParas="&tab=${tab!}"/>
            </@tag_topics>
        </div>
      </div>
    </div>
    <div class="col-md-3 d-none d-md-block">
        <#if _user??>
            <#include "components/user_info.ftl"/>
        <#else>
            <#include "components/welcome.ftl"/>
        </#if>
        <#include "components/score.ftl"/>
        <@score limit=10/>
    </div>
  </div>
</@html>
