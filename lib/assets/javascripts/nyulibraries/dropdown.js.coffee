# Requires bootstrap-dropdown script to be included in your script.
# If you're using sprockets can include it with the following require directives:
#   For .js files:
#     //= require bootstrap-dropdown
#   For .coffee files:
#     #= require bootstrap-dropdown
# 
# Basic Dropdown
class Dropdown
  init: () ->
    $(@selector).dropdown @options()

  # Contructor (obviously)
  constructor: (@selector) ->

# Load on jquery document ready
$ ->
  # Make the Dropdown accessible
  window.nyulibraries.Dropdown = Dropdown