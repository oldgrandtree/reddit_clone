class SubDecorator < Draper::Decorator
  delegate_all
  
  def submit
    object.persisted? ? "Edit Sub" : "Create Sub"
  end
  
  def form_url
    object.persisted? ? h.sub_url(object) : h.subs_url
  end
end