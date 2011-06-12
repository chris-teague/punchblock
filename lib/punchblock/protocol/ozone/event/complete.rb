module Punchblock
  module Protocol
    class Ozone
      module Event
        class Complete < OzoneNode
          # TODO: Validate response and return response type.
          # -----
          # <complete xmlns="urn:xmpp:ozone:ext:1"/>

          register :complete, :ext

          def reason
            OzoneNode.import children.select { |c| c.is_a? Nokogiri::XML::Element }.first
          end

          def attributes
            [:reason] + super
          end

          class Reason < OzoneNode
            def name
              super.to_sym
            end

            def attributes
              [:name] + super
            end
          end

          class Stop < Reason
            register :stop, :ext_complete
          end

          class Hangup < Reason
            register :hangup, :ext_complete
          end

          class Error < Reason
            register :error, :ext_complete

            def details
              text.strip
            end

            def attributes
              [:details] + super
            end
          end
        end # Complete
      end
    end # Ozone
  end # Protocol
end # Punchblock
