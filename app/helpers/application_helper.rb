module ApplicationHelper
  def safe_user_path(user)
    return "#" if user.nil? || user.id.nil?
    user_path(user.id)
  rescue StandardError
    "#"
  end
end
