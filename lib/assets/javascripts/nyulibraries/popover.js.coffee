# Requires bootstrap-tooltip and bootstrap-popover scripts to be
# included in your script. If you're using sprockets can include
# them with the following require directives:
#   For .js files:
#     //= require bootstrap/tooltip
#     //= require bootstrap/popover
#   For .coffee files:
#     #= require bootstrap/tooltip
#     #= require bootstrap/popover
#
# Basic Tooltip
class Tooltip
  # Default options
  default:
    html: true
    trigger: 'hover'
    delay: { show: 500, hide: 100 }
    placement: () ->
      element = arguments[1]
      if ($(element).offset().left > $(document).width() * .75)
        'left'
      else
        'right'

  # Tooltip options function
  options: () ->
    html: (() -> @_html ? @default.html).call(@)
    trigger: (() -> @_trigger ? @default.trigger).call(@)
    delay: (() -> @_delay ? @default.delay).call(@)
    placement: (() -> @_placement ? @default.placement).call(@)
    title: @_title

  init: () ->
    $(@selector).tooltip @options()

  # HTML option setter, allows chaining
  html: (@_html) ->  @

  # Trigger option setter, allows chaining
  trigger: (@_trigger) -> @

  # Delay option setter, allows chaining
  delay: (@_delay) -> @

  # Placement option setter, allows chaining
  placement: (@_placement) -> @

  # Title option setter, allows chaining
  title: (@_title) -> @

  # Contructor (obviously)
  constructor: (@selector) ->

# Class for basic Popovers
class Popover extends Tooltip
  _JSON_URL: 'https://web1.library.nyu.edu/common/' +
    'retrieve_file_contents_as_json.php?full_html=true&callback=?'
  # Callback method for content, returns a function
  @_CONTENT_CALLBACK: (self, json_url) ->
    ()->
      element = $(@)
      if(element.attr("data-content")?)
        element.attr("data-content")
      else
        $.getJSON json_url + "&the_url=" + element.attr("href"), (data)->
          element.attr "data-content",
            self.wrapHTML(data.theHtml, element.attr("data-class"))
          element.popover('show')
        "Loading..."

  options: () ->
    $.extend super(),
      content: @_content

  init: () ->
    $(@selector).popover @options()

  # Content options setter, allows chaining
  content: (@_content) -> @

  # Contructor (obviously)
  constructor: (@selector) ->
    @content(Popover._CONTENT_CALLBACK(@, @_JSON_URL))

  # Crappy hack to append an extra class
  wrapHTML: (html, klass) ->
    if klass?
      $("<p>").append($("<div>").addClass(klass).append(html)).html()
    else
      html

# Class for Popovers with augmented hover features
class HoverPopover extends Popover
  init: () ->
    @trigger('manual')
    $(@selector).popover(@options()).hover((e) -> e.preventDefault())
      .mouseenter((e) -> $(@).popover('show'))
      .mouseleave (e) ->
        unless $(e.relatedTarget).parent().hasClass("popover")
          $(@).popover('hide')

# Class for partial HTML retrieval
class PartialHoverPopover extends HoverPopover
  _JSON_URL: 'https://web1.library.nyu.edu/common/' +
    'retrieve_file_contents_as_json.php?callback=?'
  # Contructor (obviously)
  constructor: (@selector) ->
    this.content(Popover._CONTENT_CALLBACK(@, @_JSON_URL))

# Load on jquery document ready
$ ->
  # Make a globally accessible thingy
  window.nyulibraries ||= {}
  # Make the Tooltip accessible
  window.nyulibraries.Tooltip = Tooltip
  # Make the Popover accessible
  window.nyulibraries.Popover = Popover
  # Make the HoverPopover accessible
  window.nyulibraries.HoverPopover = HoverPopover
  # Make the PartialHoverPopover accessible
  window.nyulibraries.PartialHoverPopover = PartialHoverPopover

  # Hide popover on click in page.
  $('[class!="popover"]').click (e) -> $(".popover").hide()
  # Continue to show popover when we enter it's area
  $(document).on 'mouseenter', ".popover", (e) ->
    $(@).show()
  # Hide popover when we leave it's area
  $(document).on 'mouseleave', ".popover", (e) ->
    $(@).hide()

  # Load hover popovers to any element that has
  # substring popover in the class
  new window.nyulibraries.HoverPopover('[class*="popover"]').init()
