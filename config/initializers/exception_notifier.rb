ExceptionNotification::Notifier.exception_recipients = %w(hendra@41studio.com)
# defaults to exception.notifier@default.com
ExceptionNotification::Notifier.sender_address = %("Application Error" <app.error@prikitiw.com>)

# defaults to "[ERROR] "
ExceptionNotification::Notifier.email_prefix = "[APP] "


