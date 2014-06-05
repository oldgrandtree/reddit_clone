class PostDecorator < Draper::Decorator
  delegate_all
  
  def link
    object.url.nil? ? h.post_url(object) : object.url
  end
  
  def submit
    object.persisted? ? "Edit Post" : "Create Post"
  end
  
  def form_url
    object.persisted? ? h.post_url(object) : h.sub_posts_url(object.sub_id)
  end
  
  def top_level_comments
    object.comments.where("parent_comment_id IS NULL")
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
