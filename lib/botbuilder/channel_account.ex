defmodule BotBuilder.ChannelAccount do
    @derive [Poison.Encoder]
    defstruct [:id, :name]
end