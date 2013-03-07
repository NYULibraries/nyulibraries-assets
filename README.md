# NYU Libraries Assets
[![Build Status](https://secure.travis-ci.org/NYULibraries/nyulibraries_assets.png?branch=master)](http://travis-ci.org/NYULibraries/nyulibraries_assets?branch=development)
[![Dependency Status](https://gemnasium.com/NYULibraries/nyulibraries_assets.png)](https://gemnasium.com/NYULibraries/nyulibraries_assets)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries_assets.png)](https://codeclimate.com/github/NYULibraries/nyulibraries_assets)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/nyulibraries_assets/badge.png?branch=master)](https://coveralls.io/r/NYULibraries/nyulibraries_assets?branch=development)

## Usage
### Rails
In your gemfile,

    group :assets do
      ...
      gem 'sass-rails', "~> 3.2.5"
      gem 'compass-rails', "~> 1.0.3"
      gem 'nyulibraries_assets', :git => "git://github.com/NYULibraries/nyulibraries_assets.git"
      ...
    end

### Stylesheets
Import "nyulibraries" in your SCSS file of choice to get all NYU Libraries and Bootstrap styles, mixins and variables!

    @import "nyulibraries";
    
### Javascripts
_**Currently assumes that you're using [Sprockets](https://github.com/sstephenson/sprockets)**_

You can include the NYU Libraries javascripts through two methods. 
In this case, Sprocket's `//=` (`#=` in CoffeeScript) require directives.

We have a helper that includes all available javascripts and preps BobCat elements:

    // Loads all NYU Libraries javascripts and preps BobCat elements
    //= require bobcat

We have a helper that includes all available javascripts without prepping BobCat elements:

    // Loads all NYU Libraries javascripts without prepping BobCat elements
    //= require nyulibraries

You can also load individual modules, provided you sort out any related dependencies.

    //= require nyulibraries/popover
    //= require nyulibraries/dropdown

#### Tooltips and Popovers
NYU Libraries Popovers use Twitter Bootstrap's [Tooltips](http://twitter.github.com/bootstrap/javascript.html#tooltips) 
and [Popovers](http://twitter.github.com/bootstrap/javascript.html#popovers)

NYU Libraries Tooltips and Popovers leverage the Builder pattern to chain Bootstrap options so you can do something like this
    
    $ ->
      new window.nyulibraries.Popover('.someclass').html(false).trigger('click').init()

There are 4 classes of Tooltips/Popovers
    
1. `Tooltip` - Bootstrap tooltip
2. `Popover` - Bootstrap popover that can load HTML from an external source
3. `HoverPopover` - Popover with extended hover scope that allows users to mouseover the popover.
4. `PartialHoverPopover` - Hover popover that loads partial HTML (truncates after 250 chars) from an external source

`HoverPopover`s are enabled by default on any element that has a class with the substring "popover" (`[class*="popover"]`).

In BobCat, `Popover`s are enabled for tab tooltips and a `HoverPopover` is enable for the My Workspace help icon.

#### Dropdowns
NYU Libraries Dropdowns use Twitter Bootstrap's [Dropdowns](http://twitter.github.com/bootstrap/javascript.html#dropdowns) 

NYU Libraries Dropdowns leverage the Builder pattern to chain Bootstrap options (currently none) so you can do something like this
    
    $ ->
      new window.nyulibraries.Dropdown('.someclass').init()

There is one class of Dropdown

1. `Dropdown` - Bootstrap dropdown

In BobCat, `Dropdown`s are enabled for the Send/Share list.

### Icons and Sprites
NYU Libraries assets have sprites built in.

## Compass
Documentation coming soon.