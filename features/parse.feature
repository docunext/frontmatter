Feature: Parse frontmatter from a string 

  Scenario: Parsing a document
    Given I have a document containing frontmatter 
    When I call parse
    Then I should receive a Hash
    Then the hash should have a :content key 
    When I call has_frontmatter? 
    Then I should receive true
    When I call has_valid_frontmatter?
    Then I should receive true
