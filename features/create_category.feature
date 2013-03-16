Feature: Create a new category
  As an admin
  In order to to categorize articles
  I should be able to create a new category

  Background:
    Given the blog is set up
    And an non-admin user exists

  Scenario: Admin is presented with a form for new category
    Given I am logged in as an admin
    When I follow "Categories"
    Then I am on the new page for categories
