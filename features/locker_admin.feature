Feature: administer the locker space

  As an administrator
  I want to see what is in the locker
  So that I can know what will be processed that night
  
  Scenario Outline:
    Given I move the file "<filename>" to the locker
    When I am on the locker page
    Then I should see "Locker contents"
    And I should see "<filename>"
    
    Scenarios:
    | filename                            |
    | mc00240-001-ff0071-001-001_0001.tif  |
    | mc00336_Roundabout-July-2010-80.jpg |
    
  Scenario Outline:
    Given a holding tank with "<filename>"
    When I am on the holding tank page
    Then I should see "Holding Tank contents"
    And I should see "<filename>"
    
    Scenarios:
    | filename                            |
    | mc00240-001-ff0071-001-001_0001.tif  |
    | mc00336_Roundabout-July-2010-80.jpg |