
Feature: Articles
  Background: Define URL
      Given url apiUrl
      # Given path 'users/login'
      # And request {"user": {"email": "karate@dsl.com","password": "karate123"}}
      # When method Post
      # Then status 200
      # def token = response.user.token //this token variable will have the value of the token generated
     
      * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')       //this tokenresponse variable(an object) will hold all variable that are defined in createToken.feature file
          
      * def token = tokenResponse.authToken                  //we are accessing the authToken from the tokenresponse as tokenresponse holds all the variables from this feature file
    
   Scenario: Create a new article
    Given header Authorization = 'Token ' + token    //setting authorization
    Given path 'articles'
    And request {"article": {"title": "Karate Karate","description": "Automation testing","body": "body","tagList": []}}
    When method Post
    Then status 201
    And match response.article.title == 'Karate Karate'

  #if it is created it will get the slug value from the response and store it in variable articleId for future use
@debug
    Scenario: Create and delete articles  
    Given header Authorization = 'Token ' + token     //setting authorization
    Given path 'articles'
    And request {"article": {"title": "Delete Article","description": "Automation testing","body": "body","tagList": []}}
    When method Post
    Then status 201
    * def articleId = response.article.slug
    
    
    # here we are checking if the article is created using get request and using assertion
    Given header Authorization = 'Token ' + token     //setting authorization
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == 'Delete Article'
    
    
    #here we are deleting the created article
    Given header Authorization = 'Token ' + token    //setting authorization
    Given path 'articles',articleId   
    When method Delete
    Then status 204
    
    #to verify that our article is deleted and so we are asserting the the title is not equal to 'Our article'
    Given header Authorization = 'Token ' + token  
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != 'Delete Article'