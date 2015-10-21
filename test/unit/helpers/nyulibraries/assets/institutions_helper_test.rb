require 'test_helper'
module Nyulibraries
  module Assets
    class InstitutionsHelperTest < ActionView::TestCase
      test "current institution is default when no other criteria are met" do
        assert current_institution.code == :NYU
      end
      test "current institution is set by parameter" do
        params['institution'] = 'NYUAD'
        assert current_institution.code == :NYUAD
      end
    end
  end
end
