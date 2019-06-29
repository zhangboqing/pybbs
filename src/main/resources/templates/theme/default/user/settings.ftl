<#include "../layout/layout.ftl"/>
<@html page_title="设置" page_tab="settings">
  <div class="row">
    <div class="col-md-9">
        <#if !user.active>
          <div class="alert alert-danger">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                  aria-hidden="true">&times;</span></button>
            <strong>${i18n.getMessage("theme.default.user.settings.1")} <a href="javascript:;" id="sendActiveEmail">${i18n.getMessage("theme.default.user.settings.2")}</a> ${i18n.getMessage("theme.default.user.settings.3")}</strong>
          </div>
        </#if>
      <div class="card">
        <div class="card-header">${i18n.getMessage("theme.default.user.settings.4")}</div>
        <div class="card-body">
          <br>
          <form class="form-horizontal" onsubmit="return;">
            <div class="form-group row">
              <label for="username" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.5")}</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="username" name="username" disabled value="${user.username}"
                       placeholder="用户名">
              </div>
            </div>
            <div class="form-group row">
              <label for="telegramName" class="col-sm-2 control-label">Telegram ${i18n.getMessage("theme.default.user.settings.5")}</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="telegramName" name="telegramName"
                       value="${user.telegramName!}"
                       placeholder="Telegram ${i18n.getMessage("theme.default.user.settings.5")}">
              </div>
            </div>
            <div class="form-group row">
              <label for="website" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.6")}</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="website" name="website" value="${user.website!}"
                       placeholder="${i18n.getMessage("theme.default.user.settings.6")}">
              </div>
            </div>
            <div class="form-group row">
              <label for="bio" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.7")}</label>
              <div class="col-sm-10">
              <textarea name="bio" id="bio" rows="3" class="form-control"
                        placeholder="${i18n.getMessage("theme.default.user.settings.7")}">${user.bio!?html}</textarea>
              </div>
            </div>
            <div class="form-group row">
              <div class="offset-sm-2 col-sm-10">
                <div class="checkbox">
                  <label>
                    <input type="checkbox" id="emailNotification" <#if user.emailNotification>checked</#if>>
                    ${i18n.getMessage("theme.default.user.settings.8")}
                  </label>
                </div>
                  <#--<div class="checkbox">
                    <label>
                      <input type="checkbox" id="telegramNotification"> 有新消息发送Telegram通知
                    </label>
                  </div>-->
              </div>
            </div>
            <div class="form-group row">
              <div class="offset-sm-2 col-sm-10">
                <button type="button" id="settings_btn" class="btn btn-info">${i18n.getMessage("theme.default.user.settings.9")}</button>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="card">
        <div class="card-header">${i18n.getMessage("theme.default.user.settings.10")}</div>
        <div class="card-body">
          <form onsubmit="return;" class="form-horizontal">
            <div class="form-group row">
              <label for="email" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.11")}</label>
              <div class="col-sm-10">
                <div class="input-group">
                  <input type="email" name="email" id="email" class="form-control" value="${user.email!}"
                         placeholder="${i18n.getMessage("theme.default.user.settings.11")}"/>
                  <span class="input-group-append">
                  <button type="button" id="sendEmailCode" class="btn btn-info" autocomplete="off"
                          data-loading-text="发送中...">${i18n.getMessage("theme.default.user.settings.12")}</button>
                </span>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <label for="code" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.13")}</label>
              <div class="col-sm-10">
                <input type="text" name="code" id="code" class="form-control" placeholder="${i18n.getMessage("theme.default.user.settings.13")}"/>
              </div>
            </div>
            <div class="form-group row">
              <div class="offset-sm-2 col-sm-10">
                <button type="button" id="settings_email_btn" class="btn btn-info">${i18n.getMessage("theme.default.user.settings.14")}</button>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="card">
        <div class="card-header">${i18n.getMessage("theme.default.user.settings.15")}</div>
        <div class="card-body">
          <form onsubmit="return;" class="form-horizontal">
            <div class="form-group row">
              <label for="" class="col-sm-2 control-label" style="vertical-align: middle">${i18n.getMessage("theme.default.user.settings.16")}</label>
              <div class="col-sm-10">
                <img src="${user.avatar!}" class="avatar avatar-lg" alt="avatar"/>&nbsp;&nbsp;
                <img src="${user.avatar!}" class="avatar" style="vertical-align: bottom" alt="avatar"/>&nbsp;&nbsp;
                <img src="${user.avatar!}" class="avatar avatar-sm" style="vertical-align: bottom" alt="avatar"/>
              </div>
              <div class="offset-sm-2 col-sm-10" style="margin-top: 10px;">
                <a href="javascript:;" id="selectAvatar">${i18n.getMessage("theme.default.user.settings.17")}</a>
                <input type="file" class="d-none" name="file" id="file"/>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="card">
        <div class="card-header">${i18n.getMessage("theme.default.user.settings.18")}</div>
        <div class="card-body">
          <form onsubmit="return;" class="form-horizontal">
            <div class="form-group row">
              <label for="oldPassword" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.19")}</label>
              <div class="col-sm-10">
                <input type="password" name="oldPassword" id="oldPassword" class="form-control" placeholder="${i18n.getMessage("theme.default.user.settings.19")}"/>
              </div>
            </div>
            <div class="form-group row">
              <label for="newPassword" class="col-sm-2 control-label">${i18n.getMessage("theme.default.user.settings.20")}</label>
              <div class="col-sm-10">
                <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="${i18n.getMessage("theme.default.user.settings.20")}"/>
              </div>
            </div>
            <div class="form-group row">
              <div class="offset-sm-2 col-sm-10">
                <button type="button" id="settings_pwd_btn" class="btn btn-info">${i18n.getMessage("theme.default.user.settings.21")}</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-3 hidden-xs">
        <#include "../components/user_info.ftl"/>
        <#include "../components/token.ftl"/>
    </div>
  </div>
  <script>
    $(function () {
      $("#settings_btn").click(function () {
        var telegramName = $("#telegramName").val();
        var website = $("#website").val();
        var bio = $("#bio").val();
        var emailNotification = $("#emailNotification").is(":checked");
        $.ajax({
          url: '/api/settings',
          cache: false,
          async: false,
          type: 'put',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          data: JSON.stringify({
            telegramName: telegramName,
            website: website,
            bio: bio,
            emailNotification: emailNotification,
          }),
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.user.settings.22')}");
              setTimeout(function () {
                window.location.reload();
              }, 700);
            } else {
              err(data.description);
            }
          }
        })
      });

      // 上传头像
      $("#selectAvatar").click(function () {
        $("#file").click();
      });
      $("#file").change(function () {
        var fd = new FormData();
        fd.append("file", document.getElementById("file").files[0]);
        fd.append("type", "avatar");
        fd.append("token", "${_user.token}");
        $.post({
          url: "/api/upload",
          data: fd,
          dataType: 'json',
          headers: {
            'token': '${_user.token}'
          },
          processData: false,
          contentType: false,
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.user.settings.23')}");
              $.each($(".avatar "), function (i, v) {
                $(v).attr("src", data.detail);
              })
            } else {
              err(data.description);
            }
          }
        })
      });

      // 发送激活邮件
      $("#sendActiveEmail").on("click", function () {
        $.ajax({
          url: '/api/settings/sendActiveEmail',
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
              suc("${i18n.getMessage('theme.default.user.settings.24')}");
            } else {
              err(data.description);
            }
          }
        })
      })

      // 更改邮箱
      $("#sendEmailCode").on("click", function () {
        var loadingBtn = $(this).button("loading");
        var email = $("#email").val();
        $.ajax({
          url: '/api/settings/sendEmailCode',
          cache: false,
          async: false,
          type: 'get',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          data: {
            email: email,
          },
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.user.settings.24')}");
            } else {
              err(data.description);
            }
            loadingBtn.button("reset");
          }
        })
      })
      $("#settings_email_btn").click(function () {
        var email = $("#email").val();
        var code = $("#code").val();
        $.ajax({
          url: '/api/settings/updateEmail',
          cache: false,
          async: false,
          type: 'put',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          data: JSON.stringify({
            email: email,
            code: code,
          }),
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.user.settings.25')}");
              setTimeout(function () {
                window.location.reload();
              }, 700);
            } else {
              err(data.description);
            }
          }
        })
      })

      // 更改密码
      $("#settings_pwd_btn").click(function () {
        var oldPassword = $("#oldPassword").val();
        var newPassword = $("#newPassword").val();
        if (!oldPassword) {
          err("${i18n.getMessage('theme.default.user.settings.26')}");
          return;
        }
        if (!newPassword) {
          err("${i18n.getMessage('theme.default.user.settings.27')}");
          return;
        }
        $.ajax({
          url: '/api/settings/updatePassword',
          cache: false,
          async: false,
          type: 'put',
          dataType: 'json',
          contentType: 'application/json',
          headers: {
            'token': '${_user.token}'
          },
          data: JSON.stringify({
            oldPassword: oldPassword,
            newPassword: newPassword,
          }),
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.user.settings.28')}");
            } else {
              err(data.description);
            }
          }
        })
      });
    })
  </script>
</@html>
