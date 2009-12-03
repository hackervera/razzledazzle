module ApplicationHelper
  def embed_vimeo_tag(clip_id)
    content_tag(:object,
                (
                  content_tag(:param, nil, :name => "allowfullscreen",   :value => "true") +
                  content_tag(:param, nil, :name => "allowscriptaccess", :value => "always") +
                  content_tag(:param, nil, :name => "movie",             :value => "http://vimeo.com/moogaloop.swf?clip_id=#{clip_id}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=ffffff&amp;fullscreen=1") +
                  content_tag(:embed,
                              nil,
                              :src =>  "http://vimeo.com/moogaloop.swf?clip_id=#{clip_id}&amp;server=vimeo.com&amp;show_title=0&amp;show_byline=0&amp;show_portrait=0&amp;color=ffffff&amp;fullscreen=1",
                              :type => "application/x-shockwave-flash",
                              :allowfullscreen   => "true",
                              :allowscriptaccess => "always",
                              :width             => "629",
                              :height            => "354")

                ),
                :width  => "629",
                :height => "354"
               )
  end
end
