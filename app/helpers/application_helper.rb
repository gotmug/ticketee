module ApplicationHelper

 def title(*parts)
  @title = (parts << "Ticketee").join(" - ") unless parts.empty?
  @title || "Ticketee"
 end

 def admins_only(&block)
  block.call if current_user.try(:admin?)
  nil
 end

 def authorized?(permission, object, &block)
   block.call if can?(permission.to_sym, object) ||
     current_user.try(:admin?)
   nil
 end

end
