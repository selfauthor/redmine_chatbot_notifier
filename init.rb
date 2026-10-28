# frozen_string_literal: true

# Точка входа плагина Chatbot Notifier.
# Выполняет регистрацию плагина в Redmine и подключает патчи к ядру.

# Загружаем основной модуль плагина (определён в lib/chatbot_notifier.rb).
require_relative 'lib/chatbot_notifier'

# Регистрируем плагин в Redmine.
# На этом этапе имя и описание заданы строками — в пункте 2 (локализация)
# заменим их на символы l(:label_chatbot_notifier_name) и т.п.
Redmine::Plugin.register :chatbot_notifier do
  name 'Уведомления через чат-бот'
  author 'Андрей Якушев'
  author_url 'https://a2ya.ru'
  description 'Отправка уведомлений о событиях Redmine в Макс или другие мессенджеры параллельно с уведомлениями по электронной почте.'
  version '0.0.1'
  url 'https://github.com/selfauthor/redmine_chatbot_notifier'

  # Настройки плагина хранятся в таблице settings через Setting.plugin_chatbot_notifier.
  # UI настроек рендерится из partial app/views/settings/_chatbot_notifier_settings.html.erb.
  # Ключи и их дефолты синхронизированы с config/settings.yml.
  settings default: {
    'enabled'                    => false,
    'api_url'                    => '',
    'access_token'               => '',
    'max_user_id_custom_field_id' => 0,
    'max_text_length'            => 2000,
    'retry_intervals'            => '1,5,15,60',
    'enabled_fields'             => ''
  }, partial: 'settings/chatbot_notifier_settings'
end

# Подключаем патч к Mailer после загрузки классов Redmine.
# Rails.configuration.to_prepare вызывается:
#   - в продакшене — один раз при старте;
#   - в режиме разработки — перед каждым запросом (после перезагрузки классов).
# Это гарантирует, что патч будет применён корректно в обоих режимах.
Rails.configuration.to_prepare do
  require_relative 'lib/chatbot_notifier/patches/mailer_patch'
  # Подмешиваем патч через prepend, чтобы иметь возможность вызвать super.
  # Проверка Mailer < ... нужна, чтобы не подмешивать модуль повторно
  # при повторных вызовах to_prepare в режиме разработки.
  unless Mailer < ChatbotNotifier::Patches::MailerPatch
    Mailer.prepend(ChatbotNotifier::Patches::MailerPatch)
  end
end
# v2610281118