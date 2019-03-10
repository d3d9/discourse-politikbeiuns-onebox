# name: discourse-politikbeiuns-onebox
# about: Oneboxes for Politik bei Uns (politik-bei-uns.de)
# version: 0.1
# authors: d3d9
# url: https://github.com/d3d9/discourse-politikbeiuns-onebox

require_relative 'engine/politikbeiuns_paper_onebox'
require_relative 'engine/politikbeiuns_meeting_onebox'

# register_asset "stylesheets/..."

Onebox.options.load_paths.push(File.join(File.dirname(__FILE__), "templates"))
