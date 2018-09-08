namespace :scraping_flower_name do
  desc "scrape_flower_images"
  task :scrape_flower_images => :environment do

    require 'open-uri'
    require 'nokogiri'

    url = "https://www.shuminoengei.jp/?m=pc&a=page_p_search_category&txtSearchKaikaMonth=09"

    charset = nil
    html = open(url).read
    doc = Nokogiri::HTML.parse(html, url)

    doc.search('#resultArea div a img').each.with_index(1) do |flower,i|
      unless flower.attribute("src").nil? && flower.attribute("alt").empty?
        img = flower.attribute("src").value.to_s
        name = flower.attribute("alt").to_s
        flower = Flower.new(name: name, img: img)
        flower.save
      end
    end
  end
end
