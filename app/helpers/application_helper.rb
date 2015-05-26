module ApplicationHelper
  def navbar_links
    !current_user ? "<li>#{link_to("Log In", new_user_session_path)}</li>".html_safe : "<li>#{link_to("My Profile", "/users/#{current_user.id}")}</li><li>#{link_to("Log Out", destroy_user_session_path, method: :delete)}</li>".html_safe
  end
end