# lib/tasks/importer.rake

namespace :importer do
  desc "Importa produtos em alta da API do Google Shopping via SerpApi"
  task shopping: :environment do
    puts "🤖 Iniciando o robô importador de produtos..."

    # Define os parâmetros da busca
    params = {
      q: "trending tech gifts",
      engine: "google_shopping",
      api_key: Rails.application.credentials.serpapi[:api_key]
    }

    # Cria uma nova busca
    search = SerpApiSearch.new(params)
    
    puts "🔎 Procurando por: '#{params[:q]}'"

    # Executa a busca e obtém o resultado como um hash
    results = search.get_hash

    # Verifica se a API retornou a lista de produtos
    unless results[:shopping_results]
      puts "❌ Nenhum resultado de compras encontrado. Verifique sua chave de API ou a busca."
      next
    end

    # Processa e guarda cada produto encontrado
    puts "✅ Encontrados #{results[:shopping_results].count} produtos. Guardando na base de dados..."
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

    puts "🏆 Importação concluída! Total de #{Product.count} produtos na base de dados."
  end
end