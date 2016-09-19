defmodule BotBuilder.Conversation do
    alias BotBuilder.ChannelAccount

    defstruct isGroup: false,
        bot: %ChannelAccount{},
        members: [],
        topicName: ""
end