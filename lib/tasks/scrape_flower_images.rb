# old scraiping code
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

    doc.search('#resultArea div a img').each.with_index(1) do |flower,i|
      # 次の番号の名前とセット
      if flower.attribute("src").present?
        name = flower.attribute("src").value.to_s
        img = flower.attribute("alt").to_s
        flower = Flower.new(name: val, img: img)
        flower.save
      end
    end
  end
end
