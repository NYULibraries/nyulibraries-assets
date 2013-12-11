# Reference jQuery
$ = jQuery
# Adds plugin object to jQuery
$.fn.extend
  nyuLibraryHelp: (options) ->
    # Default settings
    settings =
      # Properties of the Widget
      base: 'https://libraryh3lp.com/chat/',
      skin: '14593',
      theme: 'gota',
      title: 'Ask+NYU+Libraries',
      identity: 'NYU',
      iframe_width: '240px',
      iframe_height: '200px',
      iframe_border: '1px solid #999',
      jid: 'askbobst@chat.libraryh3lp.com',
      # CSS Class
      wrapper_class: 'libraryh3lp',
      # Offline Text
      offline_text: '<a href="http://library.nyu.edu/ask" '+
        'target="_blank">Ask a Librarian</a>',
      # LibraryHelp JavaScript
      u_js: "https://libraryh3lp.com/js/libraryh3lp.js?multi"
    # Merge default settings with options.
    settings = $.extend(settings, options) if(options)
    # Create the LibraryHelp iframe
    return @each ()->
      # Wrap everything in a ".needs-js" div
      $(this).wrap($("<div />").addClass("needs-js"))
      iframe_wrapper = $("<div />").addClass(settings.wrapper_class).
        attr("jid",settings.jid)
      iframe_src = settings.base + settings.jid + "?skin=" + settings.skin +
        "&theme=" + settings.theme + "&title=" + settings.title +
        "&identity=" + settings.identity
      iframe = $("<iframe />")
      iframe.attr("src", iframe_src)
      iframe.attr("frameborder", 1)
      iframe.css("border", settings.iframe_border)
      iframe.css("width", settings.iframe_width)
      iframe.css("height", settings.iframe_height)
      offline = $("<div />").addClass(settings.wrapper_class).
        css("display","none").html(settings.offline_text)
      $(this).closest("div").after(iframe_wrapper.append(iframe).after(offline))

# Load on jquery document ready
# Assumes the following IDs for Ask A Librarian anchors
#   NYU NY: ny_aal
#   NYU AD: ad_aal
$ ->
  # Use defaults as baseline NYU NY settings
  ny_settings = {}
  # If we have an NYU AD link, we want to prefer that one and
  # set the NYU NY offline text to an empty span.
  unless $("a#ad_aal").length is 0
    # Load up nyuLibraryHelp iframe
    # for NYU AD
    $("a#ad_aal").nyuLibraryHelp
      title: 'Chat with a librarian ',
      jid: 'nyuad@chat.libraryh3lp.com',
      offline_text: '<a href="http://nyuad.nyu.edu/research/library/contact.html" '+
        'target="_blank">Ask a Librarian</a>'
    # Set NYU NY offline text to empty span.
    ny_settings =
      offline_text: '<span></span>'
  # Load up nyuLibraryHelp for NY
  $("a#ny_aal").nyuLibraryHelp(ny_settings)
