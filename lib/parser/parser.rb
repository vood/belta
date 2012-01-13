#encoding: utf-8
class Parser
  def self.parse text, selector, blacklist = ''
    doc = Nokogiri::HTML(text)
    doc.encoding = 'utf-8'

    nodes = selector.include?('/') ? doc.xpath(selector) : doc.css(selector)

    blacklist = blacklist.to_s.split(',').compact.uniq.join(',')
    nodes.css(blacklist).remove
    Sanitize.clean(nodes.to_html, Sanitize::Config::RELAXED).strip
  end

end