<#include "../layout/layout.ftl"/>
<@html page_title="编辑话题" page_tab="">
  <div class="row">
    <div class="col-md-9">
      <div class="card">
        <div class="card-header">${i18n.getMessage("theme.default.topic.edit.1")}</div>
        <div class="card-body">
          <form action="" onsubmit="return;" id="form">
            <div class="form-group">
              <label for="title">${i18n.getMessage("theme.default.topic.edit.2")}</label>
              <input type="text" name="title" id="title" value="${topic.title}" class="form-control" placeholder="${i18n.getMessage("theme.default.topic.edit.2")}"/>
            </div>
            <div class="form-group">
              <label for="content">${i18n.getMessage("theme.default.topic.edit.3")}</label>
              <a href="javascript:;" id="uploadImageBtn" class="pull-right">${i18n.getMessage("theme.default.topic.edit.4")}</a>
              <textarea name="content" id="content" class="form-control"
                        placeholder="${i18n.getMessage("theme.default.topic.edit.6")}">${topic.content!?html}</textarea>
            </div>
              <#--<div class="form-group">
                <label for="tags">标签</label>
                <input type="text" name="tags" id="tags" value="${tags}" class="form-control" placeholder="标签, 多个标签以 英文逗号 隔开"/>
              </div>-->
            <div class="form-group">
              <button type="button" id="btn" class="btn btn-info">${i18n.getMessage("theme.default.topic.edit.5")}</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-3 hidden-xs">
        <#include "../components/create_topic_guide.ftl"/>
    </div>
  </div>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/codemirror.min.css" rel="stylesheet">
  <script src="/static/theme/default/js/codemirror.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/mode/markdown/markdown.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/addon/display/placeholder.min.js"></script>
  <script>
    $(function () {
      CodeMirror.keyMap.default["Shift-Tab"] = "indentLess";
      CodeMirror.keyMap.default["Tab"] = "indentMore";
      window.editor = CodeMirror.fromTextArea(document.getElementById("content"), {
        lineNumbers: true,     // 显示行数
        indentUnit: 4,         // 缩进单位为4
        tabSize: 4,
        matchBrackets: true,   // 括号匹配
        mode: 'markdown',     // Markdown模式
        lineWrapping: true,    // 自动换行
      });

      $("#btn").click(function () {
        var title = $("#title").val();
        var content = window.editor.getDoc().getValue();
        // var tags = $("#tags").val();
        if (!title || title.length > 120) {
          err("${i18n.getMessage('theme.default.topic.edit.7')}");
          return;
        }
        // if (!tags || tags.split(",").length > 5) {
        //   err("请输入标签，且最多只能填5个");
        //   return;
        // }
        var _this = this;
        $(_this).button("loading");
        $.ajax({
          url: '/api/topic/${topic.id}',
          type: 'put',
          cache: false,
          async: false,
          dataType: 'json',
          headers: {
            "token": "${_user.token}",
          },
          contentType: "application/json",
          data: JSON.stringify({
            title: title,
            content: content,
            // tags: tags,
          }),
          success: function (data) {
            if (data.code === 200) {
              suc("${i18n.getMessage('theme.default.topic.edit.8')}");
              setTimeout(function () {
                window.location.href = "/topic/" + data.detail.id
              }, 700);
            } else {
              err(data.description);
              $(_this).button("reset");
            }
          }
        })
      });
    })
  </script>
    <#include "../components/upload.ftl"/>
</@html>
