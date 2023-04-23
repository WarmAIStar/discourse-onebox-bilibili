# name: discourse-onebox-bilibili
# about: 为 Discourse Onebox 增加了 bilibili 视频支持
# version: 0.0.2
# authors: MuZhou233
# url: https://github.com/MuZhou233/discourse-onebox-bilibili

require_relative "../../lib/onebox"

Onebox = Onebox

class Onebox::Engine::BilibiliOnebox
  include Onebox::Engine

  matches_regexp(/^https?:\/\/(?:www\.)?bilibili\.com\/video\/([a-zA-Z0-9]+)\/?$/)
  always_https

  def video_id
    match = uri.path.match(/\/video\/av(\d+)(\.html)?.*/)
    return "aid=#{match[1]}" if match && match[1]
    match = uri.path.match(/\/video\/BV([a-zA-Z0-9]+)(\.html)?.*/)
    return "bvid=#{match[1]}" if match && match[1]
      
    nil
  rescue
    return nil
  end

  def to_html
    <<-HTML
      <iframe 
        src='//player.bilibili.com/player.html?#{video_id}&page=1&autoplay=0&high_quality=1&danmaku=0'
        scrolling='no'
        border="0"
        frameborder="0"
        framespacing="0"
        allowfullscreen="true"
        width='480'
        height='300'
        sandbox='allow-top-navigation allow-same-origin allow-forms allow-scripts'></iframe>
    HTML
  end

  def placeholder_html
    to_html
  end
end
