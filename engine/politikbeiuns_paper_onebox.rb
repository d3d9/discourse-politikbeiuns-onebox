require_relative "politikbeiuns"

module Onebox
  module Engine
    class PolitikbeiunsPaperOnebox
      include Engine
      include LayoutSupport
      include JSON
      include PolitikbeiunsOnebox

      matches_entity("paper")
      always_https

      private

      def url
        "https://oparl.politik-bei-uns.de/#{@@entity}/#{match[:pid]}"
      end

      def match
        @match ||= @url.match(@@matcher)
      end

      def data
        return @data if @data

        mainFile = raw.key?("mainFile") ? { file_link: raw["mainFile"]["accessUrl"], file_name: raw["mainFile"]["name"] } : nil
        auxFiles = if raw.key?("auxiliaryFile") == true
        _a = []
        raw["auxiliaryFile"].each do |h|
        _a << { file_link: h["accessUrl"], file_name: h["name"] }
        end
        _a
        else
        nil
        end

        @data = {
          link: @url,
          paperType: raw["paperType"],
          reference: raw["reference"],
          name: raw["name"],
          modified: raw["modified"],
          has_auxFiles: !auxFiles.nil?,
          auxFiles: auxFiles,
          mainFile: mainFile
        }

        return @data
      end
    end
  end
end
