# Works like data-dismiss in Bootstrap, but instead of removing
# the parent element, it just hides it.
$ ->
  $("[data-hide]").on "click", (event)->
    $parent = $(@).closest("." + $(@).attr("data-hide"))
    $parent.removeClass("in")
    if $.support.transition && $parent.hasClass('fade')
      $parent.on $.support.transition.end, () ->
        $parent.hide()
        $parent.addClass("in")
    else
      $parent.trigger('closed').hide()
