require 'test_helper'
module Nyulibraries
  class InstitutionHelperTest < ActionView::TestCase
    test "default institutution is not nil" do
      assert !default_institution.nil?
    end
  end
end
