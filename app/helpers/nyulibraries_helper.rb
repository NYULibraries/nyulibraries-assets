# Assumes
#     - Rails helper function
#     - AuthPdsNyu controller methods
require 'institutions'
module NyulibrariesHelper
  # Title of application
  def title
    ""
  end

  def application
    title
  end

  def tabs_header
    title
  end

  def meta
    tag(:meta, :charset => "utf-8") +
    tag(:meta, :name => "viewport",
      :content => "width=device-width, initial-scale=1.0")+
    tag(:meta, :name => "HandheldFriendly", :content => "True")+
    tag(:meta, 'http-equiv' => "cleartype", :content => "on")+
    favicon_link_tag('https://library.nyu.edu/favicon.ico')+
    csrf_meta_tags
  end

  # Stylesheets for the layout.
  def stylesheets
    stylesheet_link_tag "application", :media => "all"
  end
 
  # Get the stylesheet base on the current
  # institution.
  def institutional_stylesheets
    stylesheet_link_tag institution.views["css"], :media => "all"
  end

  # Javascripts to include.
  def javascripts
    javascript_include_tag "application"
  end

  # Login link and icon
  def login(params={})
    (current_user) ?
      icon_tag(:logout) + link_to("Log-out #{current_user.firstname}", logout_url(params), class: "logout") :
        icon_tag(:login) + link_to("Login", login_url(params), class: "login")
  end

  # Breadcrumbs
  def breadcrumbs
    breadcrumbs = []
    if breadcrumbs.empty?
      breadcrumbs << link_to(views["breadcrumbs"]["title"], views["breadcrumbs"]["url"])
      breadcrumbs << link_to('BobCat', "http://bobcat.library.nyu.edu/#{views["dir"]}")
    end
  end

  # Show tabs
  def show_tabs
    return !tabs.empty?
  end

  # Tabs
  def tabs
    @tabs ||= views["tabs"].collect{|code, values|
      values["code"] = code
      values["url"], values["klass"] = root_url, "active" if active_tab? code
      values["link"] = link_to_with_popover(values["display"], values["url"], values["tip"], "tab")
      values
    }
  end
  alias all_tabs tabs

  def active_tab? code
    institution.active_tab.eql? code if institution.respond_to? :active_tab
  end

  # Using Gauges?
  def gauges?
    (Rails.env.eql?("production") and respond_to?(:gauges_tracking_code) and (not gauges_tracking_code.nil?))
  end

  def views
    views ||= institution.views
  end

  def institution
    current_primary_institution
  end

  def default_institution
    @default_institution ||= Institutions.defaults.first
  end

  def link_to_with_popover(*args)
    klass = args.delete_at 3
    content = args.delete_at 2
    args[2] = {"title" => args[0], 
      "data-content" => "<div class=\"#{klass}\">#{content}</div>", 
      class: "#{klass}"}
    link_to(*args)
  end

  def button_dropdown(title, list)
    dropdown(title, list, {class: ["btn-group"]}, {class: ["btn", "dropdown-toggle"]})
  end

  def right_button_dropdown(title, list)
    dropdown(title, list, {class: ["btn-group", "pull-right"]}, {class: ["btn", "dropdown-toggle"]}, {class: ["pull-right", "dropdown-menu"]})
  end

  def dropdown(title, list, html_options = {:class => "dropdown"}, toggle_html_options = {class: "dropdown-toggle"}, menu_html_options={class: "dropdown-menu"})
    toggle_html_options.merge!({"data-toggle" => "dropdown"})
    content_tag(:div, html_options) {
      content_tag(:button, title, class: "btn") +
      # Need to explicitly add margin-top for firefox. WTF?
      content_tag(:button, toggle_html_options) { content_tag(:span, nil, class: "caret", style: "margin-top: 8px;") } +
      content_tag(:ul, menu_html_options.merge(role: "menu")) {
        list.collect { |member|
          content_tag(:li){ member }
        }.join.html_safe
      }
    }
  end

  # Returns a sidebar section, complete with responsive navbar and collapsing.
  # Example1:
  #     <%= sidebar_section("help", content_tag(:h2, "Need help?")) do %>
  #       <ul class="nav-list">
  #         <li><a href="http://library.nyu.edu/help/ejournals.html" target="_blank">Help using the E-Journals A-Z tab</a></li>
  #         <li><a href="http://library.nyu.edu/research/tutorials/" target="_blank">Tutorials and self help</a></li>
  #         <li><a href="http://library.nyu.edu/ask" target="_blank" id="ny_aal">Ask a Librarian</a></li>
  #       </ul>
  #     <% end %>
  # Example2:
  #     <%= sidebar_section("help", content_tag(:h2, "3 Squares", title: "for breakfast")) do %>
  #       <%= content_tag(:h3, "First Breakfast") %>
  #       <p>Coffee and eggs</p>
  #       <%= content_tag(:h3, "Second Breakfast") %>
  #       <ul>
  #         <li>Oatmeal</li>
  #         <li>More Coffee</li>
  #       </ul>
  #       <%= content_tag(:h3, "Third Breakfast") %>
  #       <ul>
  #         <%= content_tag(:li, "Pancakes") %>
  #       </ul>
  #     <% end %>
  def sidebar_section(id, header, &block)
    content_tag(:div, class: "navbar") {
      content_tag(:a, class: ["btn", "btn-navbar"], data: {toggle: "collapse", target: "##{id}.nav-collapse"}) {
        content_tag(:span, nil, class: "icon-bar") + content_tag(:span, nil, class: "icon-bar")
      } + header +
      content_tag(:div, id: id, class: ["nav-collapse", "collapse", "sidebar-section"]) { yield }
    }
  end

  # Will output HTML pagination controls. Modeled after blacklight helpers/blacklight/catalog_helper_behavior.rb#paginate_rsolr_response
  # Equivalent to kaminari "paginate", but takes a Sunspot response as first argument. 
  # Will convert it to something kaminari can deal with (using #paginate_params), and
  # then call kaminari page_entries_info with that. Other arguments (options and block) same as
  # kaminari paginate, passed on through. 
  def page_entries_info_sunspot(response, options = {}, &block)
    per_page = response.results.count
    per_page = 1 if per_page < 1
    current_page = (response.results.offset / per_page).ceil + 1
    page_entries_info Kaminari.paginate_array(response.results, total_count: response.total).page(current_page).per(per_page), options, &block
  end

  # Retrieve a value matching a key to an icon class name
  def icons key
    (icons_info[key.to_s] || key)
  end
  
  # Load the icons YAML info file
  def icons_info
    @icons_info ||= icons_file
  end
  
  # Load the local icons first and then the app icons if exist
  def icons_file
    @icons_file = YAML.load_file( File.join(File.dirname(__FILE__), "..", "..", "config", "icons.yml") )
    @icons_file.merge!( YAML.load_file(File.join(Rails.root, "config", "icons.yml")) ) if File.exists? File.join(Rails.root, "config", "icons.yml")
    return @icons_file
  end
  
  # Generate a tooltip tag
  def tooltip_tag content, title, url = "#", placement = "right", css_classes = "help-inline record-help"
    link_to(content, url, :class => css_classes, :data => { :placement => placement }, :rel => "tooltip", :target => "_blank", :title => title)
  end

  def content_type_tag content_type
    content_tag(:figure, class: "content-type") do
      content_tag(:i, nil, class: "icons-nyu-content-type-#{content_type.downcase}") +
        content_tag(:figcaption, content_type.capitalize.gsub("_", " "))
    end
  end

  # Generate an icon tag with class key
  def icon_tag key
    content_tag :i, "", :class => icons(key)
  end
  
  # Return true if delayed_jobs gem has any jobs running
  def delayed_jobs_running?
    (defined?(Delayed::Job) and Delayed::Job.count > 0)
  end

  # Add onload code to body
  def onload ; false end

  # Classes to put on the body
  def body_class ; false end

  # Id to put on the body
  def body_id ; false end

  # Prepend some elements to the body
  def prepend_body; end

  # Prepend some elements to the yield
  def prepend_yield; end
end