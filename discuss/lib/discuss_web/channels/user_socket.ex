defmodule DiscussWeb.UserSocket do
  use Phoenix.Socket

  # channel "room:*", DiscussWeb.RoomChannel
  channel "comments:*", DiscussWeb.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "key", token, max_age: 86400) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _error} ->
        :error
    end
  end

  def id(_socket), do: nil
end
