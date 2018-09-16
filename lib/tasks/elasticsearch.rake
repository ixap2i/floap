namespace :elasticsearch do
  desc "Elasticsearchのindex作成"
  task :create_index => :environment do
    Flower.create_index!
  end

  desc "FlowerをElasticsearchに登録"
  task :import_flower => :environment do
    Flower.import
  end
end
