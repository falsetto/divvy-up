buckets = null

login = ->
  browser().navigateTo '/'
  signinButton = element('a.twitter-sign-in-btn')
  signinButton.click()

  expect(element('#total-to-divvy').val()).toBe '1,000.00'

  buckets = repeater('.bucket', 'bucket in buckets')
  expect(buckets.count()).toBe 3
  expect(element('.input-percentage').val()).toBe '10'
  expect(element('.input-name').val()).toBe 'Tithe'
  expect(element('.input-percentage:eq(1)').val()).toBe '8'
  expect(element('.input-name:eq(1)').val()).toBe 'Groceries'
  expect(element('.input-percentage:eq(2)').val()).toBe '15'
  expect(element('.input-name:eq(2)').val()).toBe 'Mortgage'
  expect(buckets.column('bucket.amount()')).
    toEqual ['100.00', '80.00', '150.00']
  expect(buckets.column('bucket.leftover()')).
    toEqual ['900.00', '820.00', '670.00']

logout = ->
  # TODO: figure out why the test runner can't find the link tag
  # element('a.logout').click()
  browser().navigateTo '/logout'

db_reset = ->
  browser().navigateTo '/db_reset'

describe 'home page', ->
  afterEach logout

  it 'provides a twitter sign in button', ->
    browser().navigateTo '/'
    signinButton = element('a.twitter-sign-in-btn')
    expect(signinButton.attr('href')).toBe '/auth/twitter'
    signinButton.click()
    expect(browser().location().path()).toBe '/app'

describe 'app page', ->
  beforeEach login

  afterEach ->
    logout()
    db_reset()

  it 'provides a delete button for each bucket', ->
    confirmCancel()
    expect(buckets.count()).toBe 3
    element('.delete-button:first').click()
    expect(buckets.count()).toBe 3

    confirmOK()
    expect(buckets.count()).toBe 3
    element('.delete-button:first').click()
    expect(buckets.count()).toBe 2

  it 'provides a shift-up button for each bucket', ->
    element('.shift-up:eq(1)').click()

    expect(buckets.column('bucket.amount()')).
      toEqual ['80.00', '100.00', '150.00']
    expect(buckets.column('bucket.leftover()')).
      toEqual ['920.00', '820.00', '670.00']

  it 'provides a shift-down button for each bucket', ->
    element('.shift-down:first').click()

    expect(element('.input-percentage').val()).toBe '8'
    expect(element('.input-name').val()).toBe 'Groceries'
    expect(buckets.column('bucket.amount()')).
      toEqual ['80.00', '100.00', '150.00']
    expect(buckets.column('bucket.leftover()')).
      toEqual ['920.00', '820.00', '670.00']

  it 'allows the user to change the percentage of each bucket', ->
    using('.bucket:eq(0)').input('bucket.percentage').enter('20')
    using('.bucket:eq(1)').input('bucket.percentage').enter('5')
    using('.bucket:eq(2)').input('bucket.percentage').enter('1')

    expect(buckets.column('bucket.amount()')).
      toEqual ['200.00', '50.00', '10.00']
    expect(buckets.column('bucket.leftover()')).
      toEqual ['800.00', '750.00', '740.00']

  it 'allows the user to change the name of each bucket', ->
    using('.bucket:eq(0)').input('bucket.name').enter('Charity')
    using('.bucket:eq(1)').input('bucket.name').enter('Food')
    using('.bucket:eq(2)').input('bucket.name').enter('Rent')

    expect(element('.input-name').val()).toBe 'Charity'
    expect(element('.input-name:eq(1)').val()).toBe 'Food'
    expect(element('.input-name:eq(2)').val()).toBe 'Rent'

  it 'allows the user to create new buckets', ->
    expect(buckets.count()).toBe 3
    element('.add-bucket a').click()
    expect(buckets.count()).toBe 4
    expect(element('.bucket:last .input-percentage').val()).toBe '0'
    expect(element('.bucket:last .input-name').val()).toBe 'New bucket'
    expect(buckets.column('bucket.amount()')).
      toEqual ['100.00', '80.00', '150.00', '0.00']
    expect(buckets.column('bucket.leftover()')).
      toEqual ['900.00', '820.00', '670.00', '670.00']

  it 'allows the user to change the sorting of new buckets', ->
    element('.add-bucket a').click()
    expect(element('.bucket .input-name:last').val()).toBe 'New bucket'
    element('.shift-up:last').click()
    expect(element('.bucket .input-name:last').val()).toBe 'Mortgage'
    element('.shift-down:eq(2)').click()
    expect(element('.bucket .input-name:last').val()).toBe 'New bucket'
