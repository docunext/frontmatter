Feature: Parse frontmatter from a string 

  Scenario: Checking a file 
    Given ./features/support/frontmatter.markdown as a path to a file containing frontmatter 
    When I call file_might_have_frontmatter? 
    Then I should receive true
    When I call file_has_frontmatter?
    Then I should receive true
