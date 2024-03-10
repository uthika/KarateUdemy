
Feature: Test for the home page
Background: dDefine URL
    Given url apiUrl
    

Scenario: Get all tags
  
  Given path 'tags'
  When method Get
  Then status 200
  And match response.tags contains ['Git', 'YouTube']
  And match response.tags !contains 'cars'
  And match response.tags == "#array"      //this is pagination validation  that tag is an array
  And match each response.tags == "#string" // to check through looping if each value of the array is string
  
  
# Scenario: Get 10 articles from the page

# Given url 'https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0'
# When method Get
# Then status 200


Scenario: Get 10 articles from the page

Given params {limit: 10, offset: 0}
Given path 'articles'
When method Get
Then status 200
And match response.articles =='#[10]'
And match response.articlesCount == 10

