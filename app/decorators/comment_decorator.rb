class CommentDecorator < Draper::Decorator
  delegate_all
  
  def submit
    object.persisted? ? "Edit Comment" : "Create Comment"
  end
  
  def form_url
    if object.persisted?
      h.comment_url(object)
    else
      object.parent_comment_id.nil? ? h.post_comments_url(object.post_id) : 
      h.comment_comments_url(object.parent_comment_id)
    end
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
