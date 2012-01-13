#encoding: utf-8
class Parser
  BLACKLIST = %w[script]
  WHITELIST = %w[b blockquote br cite em i li ol p pre
                  q s small strike strong sub sup time u]

  def self.parse text, selector, blacklist = ''
    doc = Nokogiri::HTML(text)
    doc.encoding = 'utf-8'

    nodes = selector.include?('/') ? doc.xpath(selector) : doc.css(selector)

    blacklist = (blacklist.to_s.split(',') + self::BLACKLIST).compact.uniq.join(',')
    nodes.css(blacklist).remove
    nodes.to_html
  end

end