<div class="card d-none" id="email_forget_password_div">
  <div class="card-header">${i18n.getMessage("theme.default.components.forget_password.1")}</div>
  <div class="card-body">
    <form action="" onsubmit="return;">
      <div class="form-group">
        <label for="email">${i18n.getMessage("theme.default.components.forget_password.2")}</label>
        <input type="email" id="email" name="email" class="form-control" placeholder="${i18n.getMessage("theme.default.components.forget_password.2")}"/>
      </div>
      <div class="form-group">
        <label for="captcha">${i18n.getMessage("theme.default.components.forget_password.3")}</label>
        <div class="input-group">
          <input type="text" class="form-control" id="forget_password_captcha" name="captcha" placeholder="${i18n.getMessage("theme.default.components.forget_password.3")}"/>
          <span class="input-group-append">
                <img style="border: 1px solid #ccc;" src="" class="captcha" id="emailCaptcha"/>
              </span>
        </div>
      </div>
      <div class="form-group">
        <button type="button" id="email_forget_password" onclick="email_forget_password()" class="btn btn-info">${i18n.getMessage("theme.default.components.forget_password.7")}
        </button>
        <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="right" title=""
           data-original-title="${i18n.getMessage("theme.default.components.forget_password.4")}"></i>
      </div>
    </form>
      <#if !model.isEmpty(site.oauth_github_client_id!) || !model.isEmpty(site.sms_access_key_id!)>
        <hr>
      </#if>
      <#if !model.isEmpty(site.oauth_github_client_id!)>
        <a href="/oauth/github" class="btn btn-success btn-block"><i class="fa fa-github"></i>&nbsp;&nbsp;${i18n.getMessage("theme.default.components.forget_password.5")}</a>
      </#if>
      <#if !model.isEmpty(site.sms_access_key_id!)>
        <button class="btn btn-primary btn-block" id="mobile_login_btn"><i class="fa fa-mobile"></i>&nbsp;&nbsp;${i18n.getMessage("theme.default.components.forget_password.6")}
        </button>
      </#if>
  </div>
</div>
<script>
  function email_forget_password() {
    var email = $("#email").val();
    var captcha = $("#email_captcha").val();
    if (!email) {
      err("${i18n.getMessage('theme.default.components.forget_password.8')}");
      return;
    }
    if (!captcha) {
      err("${i18n.getMessage('theme.default.components.forget_password.9')}");
      return;
    }
    $.ajax({
      url: '/api/forget_password',
      type: 'post',
      cache: false,
      async: false,
      contentType: 'application/json',
      data: JSON.stringify({
        email: email,
        captcha: captcha,
      }),
      success: function (data) {
        if (data.code === 200) {
          suc("${i18n.getMessage('theme.default.components.forget_password.10')}");
          setTimeout(function () {
            window.location.href = "/";
          }, 700);
        } else {
          err(data.description);
        }
      }
    });
  }

  function local_login_btn() {
    $("#email_forget_password_div").addClass("hidden");
    $("#mobile_login_div").addClass("hidden");
    $("#local_login_div").removeClass("hidden");
  }
</script>
