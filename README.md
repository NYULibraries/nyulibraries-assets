# NYU Libraries Assets
[![Build Status](https://secure.travis-ci.org/NYULibraries/nyulibraries-assets.png?branch=master)](http://travis-ci.org/NYULibraries/nyulibraries-assets?branch=master)
[![Dependency Status](https://gemnasium.com/NYULibraries/nyulibraries-assets.png)](https://gemnasium.com/NYULibraries/nyulibraries-assets)
[![Code Climate](https://codeclimate.com/github/NYULibraries/nyulibraries-assets.png)](https://codeclimate.com/github/NYULibraries/nyulibraries-assets)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/nyulibraries-assets/badge.png?branch=master)](https://coveralls.io/r/NYULibraries/nyulibraries-assets?branch=master)

## Usage
### Rails 4.1.x and Bootstrap 3

No more `:assets` group in Gemfile:
```ruby
gem 'sass-rails', '5.0.0.beta1'
gem 'compass-rails', '~> 2.0.0'
gem 'mustache', '0.99.4'
gem 'mustache-rails', github: 'NYULibraries/mustache-rails', tag: 'v0.2.3', require: 'mustache/railtie'
gem 'nyulibraries-assets', github: 'NYULibraries/nyulibraries-assets', tag: 'v4.6.1'
```

Note that mustache has been locked into `0.99.4`. That's because `> 0.99.4` broke the functionality and semantic versioning, clearly not a backwards compatible patch. There have since been updates but this gem has not been updated to reflect those changes yet.

Note that mustache-rails was forked and locked in at `v0.2.3`. This is because the former maintainer took the code off rubygems. The long term goal is to remove the dependency on this and switch to something that is maintained.

### Rails 3.x and Bootstrap 2
In your gemfile,

```ruby
group :assets do
  ...
  gem 'sass-rails', "~> 3.2.5"
  gem 'compass-rails', "~> 1.0.3"
  gem 'nyulibraries-assets', :git => "git://github.com/NYULibraries/nyulibraries-assets.git", :tag => "3.2.6"
  gem 'mustache-rails', github: 'NYULibraries/mustache-rails', tag: 'v0.2.3', require: 'mustache/railtie'
  ...
end
```

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

### Icons and Sprites
NYU Libraries assets have sprites built in using Compass.

The following lines in your SCSS will generate sprites from the all PNGs in `#{images_path}/icons`:

```
@import "compass";
@import "icons/*.png";
@include all-icons-sprites;
```

Read more about [Spriting with Compass](http://compass-style.org/help/tutorials/spriting/).
