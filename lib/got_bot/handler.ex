defmodule GotBot.Handler do
  def perform(entry) do
    if !is_nil(entry) && String.starts_with?(entry, "/") do
      splitten_entry = String.split(entry, " ")
      define_command(command: hd(splitten_entry), args: tl(splitten_entry))
    else
      know_nothing
    end
  end

  defp know_nothing do
    "https://weirwoodleviathan.files.wordpress.com/2015/11/unonothing.gif"
  end

  defp define_command(command: cmd, args: args) do
    query = Enum.join(args, "+") |> String.downcase

    if query == "" do
      GotBot.Command.perform_gif("white+walkers")
    else
      command_call(cmd, query)
    end
  end

  defp command_call(cmd, query) do
    case cmd do
      "/char" ->
        GotBot.Command.perform_char(query)
      "/house" ->
        GotBot.Command.perform_house(query)
      _ ->
        GotBot.Command.perform_gif(query)
    end
  end
end
