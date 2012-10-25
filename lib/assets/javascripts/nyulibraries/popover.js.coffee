# Requires bootstrap-tooltip and bootstrap-popover scripts to be included in your script.
# If you're using sprockets can include them with the following require directives:
#   For .js files:
#     //= require bootstrap-tooltip
#     //= require bootstrap-popover
#   For .coffee files:
#     #= require bootstrap-tooltip
#     #= require bootstrap-popover
# 
window.popover = {}
class Tooltip
  # Basic tooltip/popover options
  options:
    html: true
    trigger: 'hover'
    delay: { show: 500, hide: 100 }
    placement: () ->
      element = arguments[1]
      if ($(element).offset().left > $(document).width() * .75) then 'left' else 'right'

  init: () ->
    $(@selector).tooltip @options

  # HTML option setter, allows chaining
  html: (html) ->
    @options.html = html
    @

  # Trigger option setter, allows chaining
  trigger: (trigger) ->
    @options.trigger = trigger
    @

  # Delay option setter, allows chaining
  delay: (delay) ->
    @options.delay = delay
    @

  # Placement option setter, allows chaining
  placement: (placement) ->
    @options.placement = placement
    @

  # Title option setter, allows chaining
  title: (title) ->
    @options.title = title
    @

  # Contructor (obviously)
  constructor: (@selector) ->

# Make the Tooltip accessible
window.popover.Tooltip = Tooltip

class Popover extends Tooltip
  _JSON_URL: 'https://webapps.library.nyu.edu/common/retrieve_file_contents_as_json.php?full_html=true&callback=?'
  # Callback method for content, returns a function
  @_CONTENT_CALLBACK: (self, json_url) ->
    ()->
      element = $(this)
      $.getJSON json_url + "&the_url=" + element.attr("href"),
        (data)->
          element.attr "data-content", self.wrap_html(data.theHtml, element.attr("data-class"))
          element.popover('show')
      "Loading..."

  init: () ->
    $(@selector).popover @options 

  # Content options setter, allows chaining
  content: (content) ->
    @options.content = content
    @

  # Contructor (obviously)
  constructor: (@selector) ->
    console.log this
    this.content(Popover._CONTENT_CALLBACK(@, @_JSON_URL))

  # Crappy hack to append an extra class
  wrap_html: (html, klass) ->
    if klass? then $("<p>").append($("<div>").addClass(klass).append(html)).html() else html

# Make the Popover accessible
window.popover.Popover = Popover

class HoverPopover extends Popover
  init: () ->
    @trigger('manual')
    $(@selector).popover(@options).hover (e) ->
        e.preventDefault()
      .mouseenter (e) ->
        @mouseenter = e.timeStamp
        $(".popover").hide()
        $(this).popover('show')
      .mouseleave (e) ->
        $(this).popover('hide') unless $(e.relatedTarget).parent().hasClass("popover")

# Make the HoverPopover accessible
window.popover.HoverPopover = HoverPopover

class PartialHoverPopover extends HoverPopover
  _JSON_URL: 'https://webapps.library.nyu.edu/common/retrieve_file_contents_as_json.php?callback=?'
  # Contructor (obviously)
  constructor: (@selector) ->
    this.content(Popover._CONTENT_CALLBACK(@, @_JSON_URL))

# Make the PartialHoverPopover accessible
window.popover.PartialHoverPopover = PartialHoverPopover

$ ->
  # Load hover popovers to any element that has 
  # substring popover in the class
  new window.popover.HoverPopover('[class*="popover"]').init()
  # Hide popover on click in page.
  $('[class!="popover"]').click (e) -> $(".popover").hide()
  # Hide popover when we leave it's area
  $(".popover").live 'mouseleave', (e) ->
      $(this).hide()