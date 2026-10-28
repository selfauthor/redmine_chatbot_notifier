# frozen_string_literal: true

# Основной модуль плагина Chatbot Notifier.
#
# Содержит все компоненты плагина:
#   - ChatbotNotifier::Settings          — фасад для чтения настроек
#   - ChatbotNotifier::RecipientResolver — получение max_user_id из custom_values
#   - ChatbotNotifier::MessageBuilder    — рендеринг текста сообщения по шаблону
#   - ChatbotNotifier::TextTruncator     — обрезка длинных текстов
#   - ChatbotNotifier::Client            — HTTP-клиент к Max Bot API
#   - ChatbotNotifier::Logger            — обёртка над ActiveSupport::Logger
#   - ChatbotNotifier::TemporaryError    — временные ошибки (с retry)
#   - ChatbotNotifier::PermanentError    — постоянные ошибки (без retry)
#   - ChatbotNotifier::Patches           — патчи к ядру Redmine
#
# Подкомпоненты подключаются по мере реализации в соответствующих пунктах плана.
module ChatbotNotifier

end
# v2610281126