Feature: PetStore
  Background:
    * def baseUrl = 'https://petstore.swagger.io/v2'

  Scenario: Post Pet Positive Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet'
    And request requestBody
    When method Post
    And status 200
    And match response.name == "doggie"
    And def id = response.id


  Scenario: Post Pet Negative Case Example
    * def requestBody = read('../json/PetStore_negative.json')

    Given url baseUrl
    And request requestBody
    When method Post
    And status 404

  Scenario: Put Pet Positive Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet'
    And request requestBody
    When method Put
    And status 200
    And match response.name == "doggie"

  Scenario: Put Pet Negative Case Example
    * def requestBody = read('../json/PetStore_negative.json')

    Given url baseUrl
    And request requestBody
    When method Put
    And status 405

  Scenario: Get Pet FindByStatus Positive Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet/findByStatus'
    And request requestBody
    When method Get
    And status 200

  Scenario: Get Pet FindByStatus Negative Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet'
    And request requestBody
    When method Get
    And status 405

  Scenario: Get Pet petId Positive Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet/' + id
    And request requestBody
    When method Get
    And status 200
    And match response.name == "doggie"

  Scenario: Get Pet petId Negative Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet/0'
    And request requestBody
    When method Get
    And status 404
    And match response.message contains 'Pet not found'

  Scenario: Post Pet petId Positive Case Example
    * def requestBody = read('../json/PetStore.json')


    Given url baseUrl
    And path '/pet/' + id
    And multipart field name = "doggie"
    And multipart field status = "availeble"
    And multipart field id = 92233720368545974422
    #And multipart field file = { read: 'Template.xlsx', filename: 'Template.xlsx', contentType: 'multipart/form-data' }
    When method post
    Then status 200
    And match $.result == <result>

  Scenario: Post Pet petId Negative Case Example
    * def requestBody = read('../json/PetStore.json')

    Given url baseUrl
    And path '/pet/0'
    And request requestBody
    When method Post
    And status 415

  Scenario: Delete a pet

    Given url baseUrl
    And path '/pet/' + id
    When method delete
    Then status 200
    And match $.code == 200

  Scenario: Delete a pet

    Given url baseUrl
    And path '/pet/9223372036854597441'
    When method delete
    Then status 404
    And match response.message contains 'Pet not found'