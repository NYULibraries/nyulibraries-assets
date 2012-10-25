# NYU Libraries Assets
[![Build Status](https://secure.travis-ci.org/NYULibraries/nyulibraries_assets.png)](http://travis-ci.org/NYULibraries/nyulibraries_assets)
[![Dependency Status](https://gemnasium.com/NYULibraries/nyulibraries_assets.png)](https://gemnasium.com/NYULibraries/nyulibraries_assets)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/NYULibraries/nyulibraries_assets)

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

#### Tooltips Popovers
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

#### Dropdowns

### Icons and Sprites
NYU Libraries assets have sprites built in.

## Compass
Documentation coming soon.