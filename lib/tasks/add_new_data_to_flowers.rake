# namespace :add_new_data_to_flowers do
#   desc "db投入"
#   require "google/cloud/storage"
#   require "dotenv"

#   Dotenv.load
#   task :add_new_data_to_flowers => :environment
#     project_id = ENV['PROJECT_ID']

#     storage = Google::Cloud::Storage.new project: project_id
#     bucket_name = ENV['BUCKET_NAME']
#     bucket = storage.bucket bucket_name

#     puts bucket
#     # bucket.each do |f|
#     #   puts "File name is #{f.name}"
#     # end
# end
