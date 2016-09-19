defmodule BotBuilder.ConversationAccount do
    @derive [Poison.Encoder]
    defstruct [:id, :name, :isGroup]
end