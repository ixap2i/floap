namespace :describe_image_keyword do
  desc "image tagの取得, db投入"
  # require "google/cloud/vision"

  task :describe_image_kewyword => :environment do
    project_id = ENV['PROJECT_ID']
    require "google/cloud/vision"

    vision = Google::Cloud::Vision.new project: project_id

    flowers = Flower.all

    flowers.each do |fl|
      file_url  = "https://www.shuminoengei.jp/#{fl.img}"
      image = vision.image(file_name)
      image.properties.colors.each do |la|
        puts la
        begin
          fl_tag = FlowerTag.new(tag: la.to_s.gsub("(colors: )", ""), flower_id: fl.id.to_s,
            red: la.red, blue: la.blue, green: la.green)

          fl_tag.save
        rescue => e
          e.stacktrace
        end
      end
    end
  end
end
