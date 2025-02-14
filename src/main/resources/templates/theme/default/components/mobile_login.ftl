<div class="card d-none" id="mobile_login_div">
  <div class="card-header">${i18n.getMessage("theme.default.components.mobile_login.ftl.1")}</div>
  <div class="card-body">
    <form action="" onsubmit="return;">
      <div class="form-group">
        <label for="mobile">${i18n.getMessage("theme.default.components.mobile_login.ftl.2")}</label>
        <div class="input-group">
          <input type="tel" id="mobile" name="mobile" class="form-control" placeholder="${i18n.getMessage("theme.default.components.mobile_login.ftl.2")}"/>
          <span class="input-group-append">
            <button type="button" class="btn btn-default" onclick="send_sms_code()"
                    id="send_sms_code_btn">${i18n.getMessage("theme.default.components.mobile_login.ftl.3")}</button>
          </span>
        </div>
      </div>
      <div class="form-group">
        <label for="code">${i18n.getMessage("theme.default.components.mobile_login.ftl.4")}</label>
        <input type="text" id="code" name="code" class="form-control" placeholder="${i18n.getMessage("theme.default.components.mobile_login.ftl.4")}"/>
      </div>
      <div class="form-group">
        <label for="captcha">${i18n.getMessage("theme.default.components.mobile_login.ftl.5")}</label>
        <div class="input-group">
          <input type="text" class="form-control" id="mobile_captcha" name="captcha" placeholder="${i18n.getMessage("theme.default.components.mobile_login.ftl.5")}"/>
          <span class="input-group-append">
            <img style="border: 1px solid #ccc;" src="" class="captcha" id="mobileCaptcha"/>
          </span>
        </div>
      </div>
      <div class="form-group">
        <button type="button" id="mobile_login" onclick="to_mobile_login()" class="btn btn-info">${i18n.getMessage("theme.default.components.mobile_login.ftl.6")}</button>
        <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="right" title=""
           data-original-title="${i18n.getMessage("theme.default.components.mobile_login.ftl.7")}"></i>
      </div>
    </form>
      <#if !model.isEmpty(site.oauth_github_client_id!) || !model.isEmpty(site.sms_access_key_id!)>
        <hr>
      </#if>
      <#if !model.isEmpty(site.oauth_github_client_id!)>
        <a href="/oauth/github" class="btn btn-success btn-block"><i class="fa fa-github"></i>&nbsp;&nbsp;${i18n.getMessage("theme.default.components.mobile_login.ftl.8")}</a>
      </#if>
    <a class="btn btn-primary btn-block" id="local_login_btn" onclick="local_login_btn()"><i class="fa fa-sign-in"></i>&nbsp;&nbsp;${i18n.getMessage("theme.default.components.mobile_login.ftl.9")}</a>
  </div>
</div>
<script>
  $('[data-toggle="tooltip"]').tooltip();

  var count = 60;

  function send_sms_code() {
    var mobile = $("#mobile").val();
    var captcha = $("#mobile_captcha").val();
    if (!mobile) {
      err("${i18n.getMessage('theme.default.components.mobile_login.ftl.10')}");
      return;
    }
    if (!captcha) {
      err("${i18n.getMessage('theme.default.components.mobile_login.ftl.11')}");
      return;
    }
    if (count < 60) return;
    $("#send_sms_code_btn").attr('disabled', true);
    $.ajax({
      url: '/api/sms_code',
      type: 'get',
      cache: false,
      async: false,
      // contentType: 'application/json',
      data: {
        mobile: mobile,
        captcha: captcha,
      },
      success: function (data) {
        if (data.code === 200) {
          var interval = setInterval(function () {
            $("#send_sms_code_btn").text(count-- + 's');
            if (count <= 0) {
              count = 60;
              $("#send_sms_code_btn").attr('disabled', false);
              $("#send_sms_code_btn").text('${i18n.getMessage("theme.default.components.mobile_login.ftl.3")}');
              clearInterval(interval);
            }
          }, 1000);
          suc("${i18n.getMessage('theme.default.components.mobile_login.ftl.12')}");
        } else {
          $("#send_sms_code_btn").attr('disabled', false);
          err(data.description);
        }
        $(".captcha").click();
      }
    });
  }

  function to_mobile_login() {
    var mobile = $("#mobile").val();
    var code = $("#code").val();
    var captcha = $("#mobile_captcha").val();
    if (!mobile) {
      err("${i18n.getMessage('theme.default.components.mobile_login.ftl.10')}");
      return;
    }
    if (!code) {
      err("${i18n.getMessage('theme.default.components.mobile_login.ftl.13')}");
      return;
    }
    if (!captcha) {
      err("${i18n.getMessage('theme.default.components.mobile_login.ftl.11')}");
      return;
    }
    $.ajax({
      url: '/api/mobile_login',
      type: 'post',
      cache: false,
      async: false,
      contentType: 'application/json',
      data: JSON.stringify({
        mobile: mobile,
        code: code,
        captcha: captcha,
      }),
      success: function (data) {
        if (data.code === 200) {
          suc("${i18n.getMessage('theme.default.components.mobile_login.ftl.14')}");
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
    $("#local_register_div").removeClass("hidden");
  }
</script>
