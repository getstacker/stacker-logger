winston = require 'winston'

__instance__ = null

###*
Logger class.

Wrapper around winston. Use Logger instead of console.
###
class Logger
  # Enable logs for levels <= level
  level: 'trace'

  levels:
    trace: 0
    debug: 1
    verbose: 2
    data: 2
    info: 3
    warn: 4
    error: 5

  colors:
    trace: 'magenta'
    verbose: 'cyan'
    data: 'grey'
    debug: 'blue'
    info: 'green'
    warn: 'white'
    error: 'red'

  constructor: ->
    @logger = new winston.Logger
      levels: @levels
      colors: @colors
      padLevels: true
      transports: [
        new winston.transports.Console
          level: @level
          prettyPrint: true
          colorize: true
          silent: false
          timestamp: false
      ]

  inspect: (depth) ->
    setLevel: @setLevel
    trace: @trace
    debug: @debug
    data: @data
    info: @info
    warn: @warn
    error: @error
    log: @log

  # Getters/Setters
  Object.defineProperties @prototype,
    instance:
      get: ->
        __instance__ ?= new Logger
        __instance__
      set: (inst) ->
        __instance__ = inst

  setLevel: (level) ->
    @level = level
    @logger.transports.console.level = level

  trace: ->
    @logger.trace.apply @logger, arguments

  debug: ->
    @logger.debug.apply @logger, arguments

  data: ->
    @logger.data.apply @logger, arguments

  info: ->
    @logger.info.apply @logger, arguments

  warn: ->
    @logger.warn.apply @logger, arguments

  error: ->
    @logger.error.apply @logger, arguments

  log: (level) ->
    @logger.log.apply @logger, arguments


module.exports = Logger
