<div class="card">
  <div class="card-header">
    ${i18n.getMessage("theme.default.components.author.2")}
  </div>
  <div class="card-body">
    <div class="media">
      <a href="/user/${topicUser.username}" class="mr-3">
        <img src="${topicUser.avatar!}" title="${topicUser.username}" class="avatar"/>
      </a>
      <div class="media-body">
        <div class="media-heading">
          <a href="/user/${topicUser.username!}">${topicUser.username}</a>
        </div>
        <p>${i18n.getMessage("theme.default.components.author.1")}：${topicUser.score}</p>
      </div>
    </div>
    <div style="color: #7A7A7A; font-size: 12px;margin-top:5px;">
      <i>${(topicUser.bio!"${i18n.getMessage("theme.default.components.author.3")}")?html}</i>
    </div>
  </div>
</div>
