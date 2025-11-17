require 'serpapi'

namespace :importer do
  desc "Imports trending products from Google Shopping API via SerpApi"
  task shopping: :environment do
    puts "🤖 Starting product import robot..."

    api_key = ENV['SERPAPI_API_KEY']
    unless api_key
      puts "❌ ERROR: SERPAPI_API_KEY environment variable is not set."
      next
    end

    params = {
      q: "trending tech gifts",
      engine: "google_shopping",
      api_key: api_key
    }

    client = SerpApi::Client.new(params)
    
    puts "🔎 Searching for: '#{params[:q]}'"

    results = client.search

    if results[:error]
      puts "❌ API ERROR: #{results[:error]}"
      next
    end

    unless results[:shopping_results]
      puts "❌ No shopping results found. Check your API key or query."
      next
    end

    puts "✅ Found #{results[:shopping_results].count} products. Saving to database..."
    results[:shopping_results].each do |product_data|
      Product.find_or_create_by!(link: product_data[:link]) do |product|
        product.title     = product_data[:title]
        product.price     = product_data[:price]
        product.rating    = product_data[:rating]
        product.reviews   = product_data[:reviews]
        product.thumbnail = product_data[:thumbnail]
        product.source    = product_data[:source]
      end
    end

    puts "🏆 Import complete! Total of #{Product.count} products in the database."
  end
end