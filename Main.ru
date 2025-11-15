from telegram import InlineKeyboardButton, InlineKeyboardMarkup, Update
from telegram.ext import ApplicationBuilder, CommandHandler, CallbackQueryHandler, ContextTypes

# your keyboard
keyboard = [
    [InlineKeyboardButton("Профиль", callback_data="profile")]
]
reply_markup = InlineKeyboardMarkup(keyboard)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Выберите действие:", reply_markup=reply_markup)

async def button_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()  # acknowledge the callback to remove the "loading" state
    if query.data == "profile":
        # Example: edit message or send new message with profile info
        await query.edit_message_text("Здесь будет информация профиля.")
    else:
        await query.edit_message_text("Неизвестная команда.")

def main():
    # replace 'YOUR_BOT_TOKEN' with your bot token or load from env/secret manager
    app = ApplicationBuilder().token("YOUR_BOT_TOKEN").build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CallbackQueryHandler(button_handler))

    app.run_polling()

if __name__ == "__main__":
    main()
