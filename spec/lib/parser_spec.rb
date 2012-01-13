#encoding: utf-8
require 'spec_helper'

describe Parser do
  describe ".parse" do
    it "finds nodes by selector and removes nodes by blacklist" do
      text =
"<html>
<body>
  <div>
    <div class='content'><span class='trash'>trash</span>expected text <a href='#'>with link</a><script src='#'></script></div>
  </div>
</body>
</html>"
      Parser.parse(text, '.content', '.trash, script').gsub("\n", '').should eq("expected text <a href=\"#\">with link</a>")
    end
  end
end