jest.autoMockOff()

KDView = require '../src/view'

describe 'KDView', ->

  it 'works', ->

    expect(KDView).toBeDefined()


  it 'has event emitter abilities', ->

    view = new KDView

    expect(view._e).toBeDefined()
    expect(typeof view.on).toBe 'function'
    expect(typeof view.emit).toBe 'function'


  it 'calls viewLoaded method when loaded', ->

    flag = off

    class FooView extends KDView

      viewLoaded: -> flag = on

    fooView = new FooView

    expect(flag).toBe on


  it 'calls pistachio method to add subviews', ->

    class FooView extends KDView

      viewLoaded : -> @barView = new KDView { id : 'bar' }
      pistachio  : -> [@barView]

    view = new FooView

    expect(view.subviews[0].id).toBe 'bar'


