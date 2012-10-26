module BobcatHelper
  def title
    "BobCat"
  end
  alias :application :title
  alias :suite :title

  def stylesheets
    stylesheet_link_tag "bobcat"
  end

  def javascripts
    javascript_include_tag "bobcat"
  end

  def login
    (current_user) ?
      content_tag(:i, nil, :class => "icons-famfamfam-lock") + 
        link_to("Log-out #{current_user.firstname}", logout_url, :class=>"logout") :
      content_tag(:i, nil, :class => "icons-famfamfam-lock_open") + 
        link_to("Login", login_url, :class=>"login")
  end

  def sidebar
    render :partial => "#{current_primary_institution.views["dir"]}/sidebar"
  end

  def tabs
    current_primary_institution.views["tabs"].collect{|id, values|
      values["id"] = id
      values["url"], values["klass"] = root_url, "active" if values["url"].nil?
      values["link"] = link_to_with_popover(values["display"], values["url"], values["tip"], "tab")
      values
    } unless current_primary_institution.nil? or current_primary_institution.views.nil? or current_primary_institution.views["tabs"].nil?
  end

  def footer
    javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
  end
end
