login = ->
  browser().navigateTo '/'
  signinButton = element('a.twitter-sign-in-btn')
  signinButton.click()

logout = ->
  # TODO: figure out why the test runner can't find the link tag
  # element('a.logout').click()
  browser().navigateTo '/logout'

describe 'home page', ->
  afterEach logout

  it 'provides a twitter sign in button', ->
    browser().navigateTo '/'
    signinButton = element('a.twitter-sign-in-btn')
    expect(signinButton.attr('href')).toEqual('/auth/twitter')
    signinButton.click()
    expect(browser().location().path()).toEqual('/app')

describe 'app page', ->
  beforeEach login
  afterEach logout

  it 'displays the amount to divvy', ->
    expect(element('#total-to-divvy').val()).toBe '1,000.00'

  it 'displays the buckets', ->
    expect(repeater('.input-name').count()).toBe 4

  it 'provides a delete button for each bucket', ->

  it 'provides a sort-up button for each bucket', ->

  it 'provides a sort-down button for each bucket', ->

  it 'displays the percentage for each bucket', ->

  it 'allows the user to change the percentage of each bucket', ->

  it 'displays the name of each bucket', ->

  it 'allows the user to change the name of each bucket', ->

  it 'displays the divvy amount of each bucket', ->

  it 'displays the new total after each bucket is divvied', ->

  it 'allows the user to create new buckets', ->
