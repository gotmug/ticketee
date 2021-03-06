#Given /^"([^"]*)" can view the "([^"]*)" project$/ do |user, project|
#  Permission.create(:user => User.find_by_email!(user),
#   :object => Project.find_by_name!(project),
#    :action => "view")
#end

#Given do |user, project|
#  Permission.create(:user => User.find_by_email!(user),
#    :object => Project.find_by_name!(project),
#    :action => "create tickets")
#end

permission_step = /^"([^"]*)" can ([^"]*?) ([o|i]n)?\s?the "([^"]*)" project$/
Given permission_step do |user, permission, on, project|
  create_permission(user, find_project(project), permission)
end

def create_permission(email, object, action)
  Permission.create(:user => User.find_by_email!(email),
    :object => object,
    :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end

When /^I check "([^"]*)" for "([^"]*)"$/ do |permission, name|
  project = Project.find_by_name!(name)
  permission = permission.downcase.gsub(" ", "_")
  field_id = "permissions_#{project.id}_#{permission}"
  steps(%Q{When I check "#{field_id}"})
end

