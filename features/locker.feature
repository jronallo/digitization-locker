Feature: locker
  In order to start processing a scanned image
  As a user
  I want a locker space to drop files
  
  Scenario Outline: moving files from locker to holding tank
    Given a locker
    When I move the file "<filename>" to the locker
    Then I should see "<filename>" within the locker
    When the locker watching script has run enough times to make it stable
    Then I should see "<filename>" in the holding tank
    
    Scenarios:
    | filename                            |
    | mc00240-001-ff0071-001-001_0001.tif  |
    | mc00336_Roundabout-July-2010-80.jpg |
    
  Scenario Outline: processing the tank files to pairtrees
    Given a holding tank with "<original filename>"
    When the holding tank processing script runs
    Then I should see "<original filename>" in the repository pairtree
    And I should see "<converted filename>" in the access pairtree
    And I should not see "<original filename>" in the holding tank
    When I am on the resources page
    Then I should see "<original filename>"
    And I should see an image "<converted filename>"
    And I should see "<title>"
    
    Scenarios:
    | original filename                   | converted filename                   | title |
    | mc00240-001-ff0071-001-001_0001.tif  | mc00240-001-ff0071-001-001_0001.jpg | Amos Hosiery Mill - Factory Building, 1941 :: Drawings, 1917-1980 |
    | mc00336_Roundabout-July-2010-80.jpg | mc00336_Roundabout-July-2010-80.jpg  | mc00336 Roundabout July 2010 80 |

  
