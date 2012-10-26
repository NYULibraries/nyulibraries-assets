# Rails helper module for bobcat layout.
# Assumes 
#     - Rails helper function
#     - AuthPdsNyu controller methods
module BobcatHelper
  # Title of the Applications
  def title
    "BobCat"
  end
  alias :application :title
  alias :suite :title

  # Stylesheets for the layout.
  def stylesheets
    stylesheet_link_tag "application"
  end

  # Javascripts to include.
  def javascripts
    javascript_include_tag "application"
  end

  # Login link and icon
  def login
    (current_user) ?
      content_tag(:i, nil, :class => "icons-famfamfam-lock") + 
        link_to("Log-out #{current_user.firstname}", logout_url, :class=>"logout") :
      content_tag(:i, nil, :class => "icons-famfamfam-lock_open") + 
        link_to("Login", login_url, :class=>"login")
  end

  # Breadcrumbs
  def crumbs
    current_institution = current_primary_institution.nil? ? "NYU" : current_primary_institution.name
    views = institution["views"]
    crumbs = []
    breadcrumbs = views["breadcrumbs"]
    crumbs << link_to(breadcrumbs["title"], breadcrumbs["url"])
    crumbs << link_to('BobCat', "http://bobcat.library.nyu.edu/#{views["dir"]}")
  end

  # Sidebar partial
  def sidebar
    render :partial => "#{current_primary_institution.views["dir"]}/sidebar" unless current_primary_institution.nil?
  end

  # Tabs
  def tabs
    institution["views"]["tabs"].collect{|id, values|
      values["id"] = id
      values["url"], values["klass"] = root_url, "active" if values["url"].nil?
      values["link"] = link_to_with_popover(values["display"], values["url"], values["tip"], "tab")
      values
    }
  end

  # Footer
  def footer
    javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
  end

  def institution
    institution = institutions[current_primary_institution.nil? ? "NYU" : current_primary_institution.name]
    puts institution.inspect
    institution
  end

  def institutions
    @institutions || YAML.load_file( File.join("#{File.dirname(__FILE__)}/..", "config", "institutions.yml") )
  end

  def link_to_with_popover(*args)
    klass = args.delete_at 3
    content = args.delete_at 2
    args[2] = {"title" => args[0], "data-content" => "<div class=\"#{klass}\">#{content}</div>", :rel => "popover", :class => "#{klass}"}
    link_to(*args)
  end
end