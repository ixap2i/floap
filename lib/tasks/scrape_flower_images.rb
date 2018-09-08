namespace :scrape_flower_images do
 desc "scrape_flower_images"
  task :scrape_flower_images => :environment do

    require 'open-uri'
    require 'nokogiri'

    url = "https://www.shuminoengei.jp/?m=pc&a=page_p_search_category&txtSearchKaikaMonth=09"

    charset = nil
    html = open(url).read
    doc = Nokogiri::HTML.parse(html, url)

    p doc.title

    # 画像のurlパス
    # p doc.xpath('//*[@id="main"]/div[1]/a[1]/img').attribute("src").value
    # 花の名前
    # p doc.xpath('//*[@id="main"]/div[1]/a[2]').children.inner_text

    doc.search('#resultArea div a img').each.with_index(1) do |flower,i|
      # 次の番号の名前とセット
      unless flower.attribute("src").nil?
        # p "#{i}___"
        #
        name = flower.attribute("src").value.to_s
        img = flower.attribute("alt").to_s
        # p "1"+val.to_s
        # p "2"+flower.attribute("alt").to_s
        #
        # p "___end"
        # p
        flower = Flower.new(name: val, img: img)
        flower.save
      end
    end
  end
end
