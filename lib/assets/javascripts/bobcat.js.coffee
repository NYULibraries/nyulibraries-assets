# Require 'nyulibraries' 
#= require nyulibraries
$ ->
  # BobCat Tabs Tips
  new window.nyulibraries.Popover("#bobcat_tabs .nav-tabs li a").init()
  # My Workspace Help Popover
  new window.nyulibraries.PartialHoverPopover("#account h2 a").init()
