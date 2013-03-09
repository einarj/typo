require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^an non\-admin user exists$/ do
  User.create(
    :login => "nonadmin",
    :password => "aaaaaaaa",
    :profile_id => 2,
    :state => 'active')
end

Given /^I am logged in as an admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
end

Given /^An article exists with the title: "(.*?)"$/ do |title|
  a = Article.create!(:title => title)
  puts "CREATED ARTICLE WITH ID: #{a.id}"
end


Then /^I should( not)? be presented with a merge button$/ do |negate|
  #pending "We need to add the Merge form to the edit page"
  if negate 
    page.should_not have_button("Merge") 
  else
    page.should have_button("Merge")
  end
end

Then /^I should be presented with a "(.*?)" input field$/ do |field_id|
  page.should have_field(field_id)
end

Given /^I am logged in a an user$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'nonadmin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  #pending # express the regexp above with the code you wish you had
end

When /^I click the merge button$/ do
  click_button 'Merge'
end

Then /^I should see the message "(.*?)"$/ do |message|
  page.should have_selector(".notice")
  page.find(".notice").text.should == message
end

When /^I enter the ID of "(.*?)" into the merge id field$/ do |article|
  article = Article.find_by_title(article)
  fill_in 'merged_article_id', :with => article.id
end

Then /^It it the latest article$/ do
  id = current_url.split("/").last.to_i
  article = Article.find_by_id(id)
  id.should == Article.last.id

  source_articles = Article.find_all_by_title(article.title)
  debugger
  id.should_not == source_article.id
end
