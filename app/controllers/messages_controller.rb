class MessagesController < ApplicationController
  before_action :find_conversation

  def index
    @messages = @conversation.messages

    # We're going to use the @over_ten variable to limit the message showing up on the conversation
    # to the last 10 and if the user wants to the more he just have to click on a link (in the view)
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def new
    @message = @conversation.messages.new
  end

  private

    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end
