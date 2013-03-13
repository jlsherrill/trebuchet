# Copyright (c) 2013 Red Hat
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Trebuchet
  module Operation
    class MassRegistration < Trebuchet::Engine::MultiOperation

      def self.name
        "MassSystemRegistration"
      end

      def self.description
        "Does a large scale system registration test."
      end

      def operation_list
        list = [
          Trebuchet::Operation::Common::SetupOrganization,
          Trebuchet::Operation::Common::TieredSystemRegistration,
        ]
        list << Trebuchet::Operation::Common::CleanupOrganization if @config[:cleanup]

        list.collect do |op|
          op.name = self.class.name
          op = op.new(@config)
          op.set_params(params)
          op
        end
      end

      def params
        @params ||= {
            :org => "PerformanceOrg#{rand(10000)}",
            :environments => ['DEV'],
            :systems => 200
        }
        @params
      end
    end

  end
end