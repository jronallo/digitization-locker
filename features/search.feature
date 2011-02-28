Feature: search
  In order to find a specific item in the repository
  As a administrator
  I want to search the collection
  
  Scenario:
    Given I have "mc00240-001-ff0071-001-001_0001.tif" in the repository
    And I am on the home page
    When I fill in "Search" with "Amos"
    And I press "Submit"
    Then I should see "Amos Hosiery Mill"

  
