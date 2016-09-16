defmodule BotBuilder.Connector do
    @moduledoc """
    A module that handles interacting with BotBuilder Connector API.

    This can be used in your controller as:
        params
        |> Connector.parse_activity
        |> Connector.reply("Hi there")
    """

    alias BotBuilder.{Activity, ChannelAccount, ConversationAccount, Conversation}

    @spec parse_activity(map) :: Activity
    def parse_activity(%{} = params) do
        # TODO: Do we really need to encode then decode?
        params
        |> Poison.encode!
        |> Poison.decode!(as: %Activity{conversation: %ConversationAccount{}, from: %ChannelAccount{}, recipient: %ChannelAccount{}})
    end

    @spec reply(Activity, String.t) :: any
    def reply(%Activity{} = activity, message) do
        # Create the response and post it to the connector API
        # TODO: Should we do the post async without waiting for it?
        # TODO: How to handler failures in encoding or posting? Right now we are raising exceptions (!)
        url = 
        activity.serviceUrl
        |> URI.parse
        |> URI.merge("v3/conversations/" <> activity.conversation.id <> "/activities")
        |> to_string
        
        %{
            type: "message",
            from: activity.recipient, 
            conversation: activity.conversation,
            recipient: activity.from,
            text: message}
        |> post(url)
    end

    @spec create_conversation(Conversation, String.t) :: any
    def create_conversation(%Conversation{} = conversation, serviceUrl) do
        url = 
        serviceUrl
        |> URI.parse
        |> URI.merge("v3/conversations/")
        |> to_string

        conversation
        |> post(url)
    end

    @spec post(map, String.t) :: any
    defp post(%{} = data, url) do            
        body = Poison.encode!(data)
        HTTPotion.post!(url, [body: body, headers: [{"Content-Type", "application/json"}]])
    end
end
