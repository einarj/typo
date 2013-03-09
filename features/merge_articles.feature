Feature: Merge Articles
As an admin
In order to avoid duplicate content
I want to be able to merge two similar articles

  Background:
    Given the blog is set up
    And an non-admin user exists

  Scenario: Admin is presented with a merge button
    Given I am logged in as an admin
    And An article exists with the title: "Mergable article" and body: "Foo"
    When I am on the edit page for "Mergable article"
    Then I should be presented with a merge button
    And I should be presented with a "merged_article_id" input field

  Scenario: A non-admin cannot merge two articles
    Given I am logged in a an user
    And An article exists with the title: "Mergable article" and body: "Foo"
    When I am on the edit page for "Mergable article"
    Then I should not be presented with a merge button

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged in as an admin
    And An article exists with the title: "Original Article" and body: "Body1"
    And An article exists with the title: "New Article" and body: "Body2"
    When I am on the edit page for "New Article"
    And I enter the ID of "Original Article" into the merge id field
    And I click the merge button
    Then I am on the edit page for "New Article"
    #And I should see the message "Article merged!"
    And It it the latest article
    And The newly created "New Article" contains the text from "Original Article"
    And The newly created "New Article" contains the text from "New Article"

  #Scenario: When articles are merged, the merged article should have one author (either one of the authors of the two original articles).

  #Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.

  #Scenario: The title of the new article should be the title from either one of the merged articles.

  #Scenario: The form field containing the ID of the article to merge with must have the HTML attribute name set to merge_with
