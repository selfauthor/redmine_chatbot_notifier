# frozen_string_literal: true

module ChatbotNotifier
  module Patches
    # Патч к классу Mailer для перехвата событий отправки email-уведомлений.
    #
    # Механизм работы:
    #   1. Redmine вызывает методы Mailer.issue_add / issue_edit / wiki_* / ...
    #   2. Благодаря prepend, сначала выполняются наши методы-обёртки.
    #   3. Мы вызываем super — отрабатывает оригинальная логика Mailer
    #      (формируются recipients, рендерятся шаблоны, ставится в очередь email).
    #   4. После super мы берём список recipients и для каждого получателя:
    #        - читаем max_user_id из custom_values (RecipientResolver);
    #        - если пусто — пропускаем;
    #        - иначе — ставим в очередь ChatbotNotificationJob.
    #
    # Такой порядок гарантирует:
    #   - идентичный список получателей с email-уведомлением;
    #   - независимость от delivery_method и от того, упадёт email или нет.
    #
    # На этом этапе модуль пуст — конкретные методы будут добавлены в пункте 12.
    module MailerPatch
      # Методы патча (issue_add, issue_edit, wiki_content_added и т.д.)
      # будут реализованы в пункте 12 плана разработки.
    end
  end
end
# v2610281129