require_relative "politikbeiuns"

module Onebox
  module Engine
    class PolitikbeiunsMeetingOnebox
      include Engine
      include LayoutSupport
      include JSON
      include PolitikbeiunsOnebox

      matches_entity("meeting")
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

        einladung = if raw.key?("invitation") == true
        raw["invitation"]["accessUrl"]
        else
        nil
        end

        top_list = if raw.key?("agendaItem") == true
        _t = []
        raw["agendaItem"].each do |h|
        _t << { top_no: h["number"], top_name: h["name"] }
        end
        _t
        else
        nil
        end

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
          name: raw["name"],
          start: raw["start"],
          end: raw["end"],
          modified: raw["modified"],
          einladung: einladung,
          top_list: top_list,
          has_auxFiles: !auxFiles.nil?,
          auxFiles: auxFiles,
        }

        return @data
      end
    end
  end
end
