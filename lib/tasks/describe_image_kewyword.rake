namespace :describe_image_kewyword do
  desc "image tagの取得, db投入"
  require "google/cloud/vision"

  task :describe_image_kewyword => :environment do
    project_id = ENV['PROJECT_ID']
    vision = Google::Cloud::Vision.new project: project_id

    flowers = Flower.all
    flowers.each do |fl|
      file_name  = "https://www.shuminoengei.jp/#{fl.img}"
      image = vision.image(file_name)
      puts "Labels:"
      puts "flower_id: #{fl.id}"
      puts "flower_id: #{fl.name}"
      image.properties.colors.each do |la|
        puts la
        begin
          fl_tag = FlowerTag.new(tag: la.to_s.delete("(colors: )"), flower_id: fl.id.to_s)
          fl_tag.save
        rescue => e
        end
      end
    end
  end
end
