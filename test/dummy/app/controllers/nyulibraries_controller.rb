class NyulibrariesController < ApplicationController
  # Use the action name as the layout
  layout :layout_from_action_name

  def application;end

  def bobcat;end

  def eshelf;end

  def print;end

  def login;end

  def layout_from_action_name
    action_name
  end
  private :layout_from_action_name
end
