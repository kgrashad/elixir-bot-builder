defmodule BotBuilder.Activity do
    @derive [Poison.Encoder]
    defstruct [
        :attachements,
        :channelId,
        :entities,
        :serviceUrl,
        :text,
        :timestamp,
        :message,
        :conversation,
        :from,
        :recipient]
end