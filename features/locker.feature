Feature: locker
  In order to start processing a scanned image
  As a user
  I want a locker space to drop files
  
  Scenario Outline: moving files into the locker
    Given a locker
    When I move the file "<filename>" to the locker
    Then I should see "<filename>" within the locker
    When the locker processing script has run enough times to make it stable
    Then I should see "<filename>" in the holding tank
    
    Scenarios:
    | filename                            |
    | mc00383-001-ff0002-001-003_001.tif  |
    | mc00336_Roundabout-July-2010-80.jpg |

  
