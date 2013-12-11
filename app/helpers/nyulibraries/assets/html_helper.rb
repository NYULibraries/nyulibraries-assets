# Rails helper module for HTML
module Nyulibraries
  module Assets
    module HtmlHelper

      # Returns a link with a Bootstrap popover
      def link_to_with_popover(*args)
        klass = args.delete_at 3
        content = args.delete_at 2
        args[2] = {"title" => args[0], 
          "data-content" => "<div class=\"#{klass}\">#{content}</div>", 
          class: "#{klass}"}
        link_to(*args)
      end

      # Returns a Bootstrap button dropdown menu
      def button_dropdown(title, list, toggle_button = true)
        dropdown(title, list, toggle_button, {class: ["btn-group"]}, {class: ["btn", "dropdown-toggle"]})
      end

      # Returns a Bootstrap button dropdown menu, pulled right
      def right_button_dropdown(title, list, toggle_button = true)
        dropdown(title, list, toggle_button, {class: ["btn-group", "pull-right"]}, {class: ["btn", "dropdown-toggle"]}, {class: ["pull-right", "dropdown-menu"]})
      end

      # Returns a Bootstrap dropdown
      def dropdown(title, list, toggle_button = true, html_options = {:class => "dropdown"}, toggle_html_options = {class: "dropdown-toggle"}, menu_html_options={class: "dropdown-menu"})
        data_toggle_option = {data: {toggle: "dropdown"}}
        toggle_html_options.merge!(data_toggle_option)
        button_html_options = {class: "btn"}
        button_html_options.merge!(data_toggle_option) if toggle_button
        content_tag(:div, html_options) {
          content_tag(:button, title, button_html_options) +
          # Need to explicitly add margin-top for firefox. WTF?
          content_tag(:button, toggle_html_options) { content_tag(:span, nil, class: "caret", style: "margin-top: 8px;") } +
          content_tag(:ul, menu_html_options.merge(role: "menu")) {
            list.collect { |member|
              content_tag(:li){ member }
            }.join.html_safe
          }
        }
      end

      # Returns a sidebar section, complete with Bootstrap responsive navbar and collapsing.
      # Example1 - closed sidebar section:
      #     <%= sidebar_section("help", content_tag(:h2, "Need help?")) do %>
      #       <ul class="nav-list">
      #         <li><a href="http://library.nyu.edu/help/ejournals.html" target="_blank">Help using the E-Journals A-Z tab</a></li>
      #         <li><a href="http://library.nyu.edu/research/tutorials/" target="_blank">Tutorials and self help</a></li>
      #         <li><a href="http://library.nyu.edu/ask" target="_blank" id="ny_aal">Ask a Librarian</a></li>
      #       </ul>
      #     <% end %>
      # Example2 - Open sidebar section:
      #     <%= sidebar_section("help", content_tag(:h2, "3 Squares", title: "for breakfast"), true) do %>
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
      def sidebar_section(id, header, open = false, &block)
        collapse_classes = ["nav-collapse", "collapse", "sidebar-section"]
        style = ""
        if open
          collapse_classes << "in"
          style = "height: auto;"
        end
        content_tag(:div, class: "navbar") {
          content_tag(:a, class: ["btn", "btn-navbar"], data: {toggle: "collapse", target: "##{id}.nav-collapse"}) {
            content_tag(:span, nil, class: "icon-bar") + content_tag(:span, nil, class: "icon-bar")
          } + header +
          content_tag(:div, id: id, class: collapse_classes, style: style) { yield }
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
        @icons_file = YAML.load_file( File.join(nyulibraries_assets_root, "config", "icons.yml") )
        @icons_file.merge!( YAML.load_file(File.join(Rails.root, "config", "icons.yml")) ) if File.exists? File.join(Rails.root, "config", "icons.yml")
        return @icons_file
      end

      # Return link with a Bootstrap tooltip
      def tooltip_tag content, title, url = "#", placement = "right", css_classes = "help-inline record-help"
        link_to(content, url, :class => css_classes, :data => { :placement => placement }, :rel => "tooltip", :target => "_blank", :title => title)
      end

      # Returns an NYU Libraries content type figure for the given content type
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
    end
  end
end
