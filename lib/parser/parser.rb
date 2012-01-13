#encoding: utf-8
class Parser
  def self.parse text, selector, blacklist = ''
    doc = Nokogiri::HTML(text)
    doc.encoding = 'utf-8'

    nodes = selector.include?('/') ? doc.xpath(selector) : doc.css(selector)

    blacklist = blacklist.to_s.split(',').compact.uniq.join(',').strip
    if blacklist.length > 1
      nodes.css(blacklist).remove
    end
    Sanitize.clean(nodes.to_html, Sanitize::Config::RESTRICTED.merge(:remove_contents => %w[script img])).strip
  end

end