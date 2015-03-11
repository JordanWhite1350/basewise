module ApplicationHelper
  def user_name(user)
    return nil unless user
    ": #{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def session_links(user)
    if user
      link_to "Log Out", logout_path, method: :delete
    else
      content_tag(:span, class: "session_links") do
        link_to("Signup", register_path) +
        link_to("Login", signin_path)
      end
    end
  end
end
