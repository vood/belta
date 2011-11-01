require 'open-uri'
module CrawlerHelper
  BLACKLIST = %w['script']
  WHITELIST = %w[b blockquote br cite em i li ol p pre
                q s small strike strong sub sup time u]

  def get_body entry, feed
    doc = Nokogiri::HTML(open(entry.url))
    doc.encoding = 'utf-8'

    nodes = feed.xpath_selector ? doc.xpath(feed.selector) : doc.css(feed.selector)
    html = nodes.to_html

    sanitize html, self::WHITELIST, self::BLACKLIST | feed.selector_blacklist_array
  end

  def sanitize html, whitelist, blacklist
    Sanitize.clean(html, :elements => whitelist, :remove_contents => blacklist)
  end

  def entry_matches entry, regex
    (entry.title && entry.title.match(regex)) || (entry.summary && entry.summary.match(regex))
  end
end
