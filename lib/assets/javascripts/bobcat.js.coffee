# Require 'nyulibraries' 
# = require nyulibraries
$ ->
  # BobCat Tabs Tips
  new window.popover.Popover(".nav-tabs li a").init()
  new window.popover.PartialHoverPopover("#account h2 a").init()
