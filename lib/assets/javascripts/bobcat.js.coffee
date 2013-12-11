# Require 'nyulibraries'
#= require nyulibraries
$ ->
  # BobCat Tabs Tips
  new window.nyulibraries.Popover("#bobcat_tabs .nav-tabs li a").init()
  # My Workspace Help Popover
  new window.nyulibraries.PartialHoverPopover("#sidebar h2.workspace a").init()
