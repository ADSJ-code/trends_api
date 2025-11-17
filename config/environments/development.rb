Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is critical for development.
  config.enable_reloading = true

  # Eager load code on boot. This will force caching of all fragments.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = :none

  # Logger is used to debug and understand application progress.
  config.logger = ActiveSupport::Logger.new($stdout)
  config.logger.formatter = ::Logger::Formatter.new
  config.logger.debug_purpose = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Highlight code that triggered database queries in logs.
  # config.active_record.highlight_all_queries_in_log = true # Linha desnecessária para Mongoid

  # Raises error for missing translations in views.
  # config.action_view.raise_on_missing_translations = true
end