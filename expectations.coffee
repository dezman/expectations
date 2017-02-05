class Spec
  constructor: ->
    @currentValue = null

    window.it = @it
    window.expect = @expect

  it: (name, executable) =>
    if validations = @validateSpec(name, executable)
      console.error validations
    else if !executable()
      console.warn "IT DOES NOT #{name}."
    else
      console.log "it does #{name}."
      true

  validateSpec: (name, executable) ->
    numberOfExpectations = executable.toString().split('expect').length
    if numberOfExpectations == 2
      ''
    else if numberOfExpectations > 2
      "Spec '#{name}' has more than one expectation within an it block, which is not allowed."
    else
      "Spec '#{name}' has no expectations in it."

  expect: (value) =>
    @currentValue = value
    this

  toBe: (value) =>
    @currentValue == value

  notToBe: (value) =>
    @currentValue != value

new Spec()

# spec specs
do ->
  it 'know that true equals true', ->
    expect(true).toBe(true)

  it 'know that true does not equal false', ->
    expect(true).notToBe(false)

  it 'know that an object equals the same object', ->
    obj =
      toots: 'mcgoots'
    expect(obj).toBe(obj)

  it 'know that different objects are not the same', ->
    expect({}).notToBe({})
