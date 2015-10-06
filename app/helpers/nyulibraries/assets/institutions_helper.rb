# Rails helper module for institutions
module Nyulibraries
  module Assets
    module InstitutionsHelper
      # Determine current primary institution based on:
      #   0. institutions are not being used (returns nil)
      #   1. institution query string parameter in URL
      #   2. institution associated with the client IP
      #   3. primary institution for the current user
      #   4. first default institution
      def current_institution
        @current_institution ||= case
        when (institution_param.present? && institutions[institution_param])
          institutions[institution_param]
        when institution_from_ip.present?
          institution_from_ip
        when (@current_user && current_user.try(:institution_code).present?)
          institutions[current_user.institution_code.to_sym]
        else
          Institutions.defaults.first
        end
      end
      alias current_primary_institution current_institution
      alias current_institute current_institution

      # Override Rails #url_for to add institution
      def url_for(options={})
        if institution_param.present? and options.is_a? Hash
          options[:institution] ||= institution_param
        end
        if institute_param.present? and options.is_a? Hash
          options[:institute] ||= institute_param
        end
        super options
      end

      # Grab the first institution that matches the client IP
      def institution_from_ip
        unless request.nil?
          @institution_from_ip ||= begin
            institutions_from_ip = institutions.find_all do |code, institution|
              institution.includes_ip? request.remote_ip
            end
            # Get the first found institution in form { :NYU => Institution }
            # then get the institution object, rescue if nothing is found
            # so conditional can move on
            institutions_from_ip.first.last rescue nil
          end
        end
      end
      private :institution_from_ip

      # Get the institution from a given code
      def institution_from_code(code)
        unless code.nil?
          @institution_from_code ||= institutions[code.upcase.to_sym]
        end
      end
      private :institution_from_code

      # All institutions
      def institutions
        @institutions ||= {}
        Institutions.institutions.each do |code, institution|
          unless institution.ip_addresses.nil? || institution.ip_addresses.is_a?(IPAddrRangeSet)
            institution.send("ip_addresses=", institution.ip_addresses)
          end
          @institutions[code] = institution
        end
        @institutions
      end
      private :institutions

      # The institution param as a Symbol
      def institution_param
        params['institution'].upcase.to_sym if params['institution'].present?
      end
      private :institution_param

      # The institute param as a Symbol
      # failover to institute if it exists for backwards compatibility
      def institute_param
        params['institute'].upcase.to_sym if params['institute'].present?
      end
      private :institute_param
    end
  end
end
