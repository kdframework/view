{ KDViewNode } = require 'kdf-dom'
PistachioMixin = require 'kdf-pistachio/lib/mixin'
KDEventEmitter = require 'kdf-event-emitter'

noop = ->

###*
 * @class KDView
 *
 * Main Data structure to represent an interactive
 * node in `KDDom` tree. `KDViewNode` on steroids.
 * It defines some event listeners to define a lifecycle
 * for view itself. The reason not to put these lifecycle bindings
 * into a mixin is actually this class needs to define those lifecycle
 * events so that mixins would have some idea or defaults to
 * mix themselves in whichever part they want in the lifecycle.
###
module.exports = class KDView extends KDViewNode

  @include KDEventEmitter
  @include PistachioMixin, no

  constructor: (options = {}, data) ->

    # Apply constructor of event emitter
    # to have event handling abilities.
    KDEventEmitter.call this

    super options, data

    @addLifecycleListeners()
    @fireLifecycleListeners()


  ###*
   * Fires necessary lifecycle events in order to
   * create lifecycle.
   *
   * @fires KDView#ViewLoaded
  ###
  fireLifecycleListeners: ->

    @emit 'ViewLoaded'


  ###*
   * Creates listeners to listen lifecycle events and
   * forwards them to some default methods.
   *
   * @listens KDView#ViewLoaded
  ###
  addLifecycleListeners: ->

    # We are ready to init some subviews and stuff,
    # `KDView#viewLoaded` will be the new `init`.
    @on 'ViewLoaded', @bound 'viewLoaded'

    # by setting a different handler after general
    # `viewLoaded` handler method, we are making sure that
    # subview initializations are happening before calling
    # pistachio method, and setting subview count.
    # TODO: this needs to be optimized, setSubviewCount
    # is already being called in `KDViewNode` constructor
    # so for kdviews we need to have a way to avoid that call
    # over there.
    @on 'ViewLoaded', =>

      PistachioMixin.call this
      @setSubviewCount()


  viewLoaded: noop


