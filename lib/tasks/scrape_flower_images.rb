require 'open-uri'
require 'nokogiri'

url = "http://photo-chips.com/list/flower/1.html"

charset = nil
html = open(url).read
doc = Nokogiri::HTML.parse(html, url)

p doc.title

# 画像のurlパス
# p doc.xpath('//*[@id="main"]/div[1]/a[1]/img').attribute("src").value
# 花の名前
# p doc.xpath('//*[@id="main"]/div[1]/a[2]').children.inner_text



doc.search('#main div a').each.with_index(1) do |flower,i|
  # 次の番号の名前とセット
  unless flower.children.attribute("src").nil?
    p "#{i}___"
    
    val = flower.children.attribute("src").value
    p "1"+val.to_s
    p "2"+flower.children.attribute("alt").to_s
    
    p "3" +flower.inner_text
    p "___end"
    p

    
  
  end
end
