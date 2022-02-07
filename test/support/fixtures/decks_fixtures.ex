defmodule Rafiyol.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rafiyol.Decks` context.
  """

  @doc """
  Generate a unique deck name.
  """
  def unique_deck_name, do: "some name#{System.unique_integer([:positive])}"

  defp create_deck(attrs, user_id), do: Rafiyol.Decks.create_deck(user_id, attrs)

  @doc """
  Generate a deck.
  """
  def deck_fixture(user_id, attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        name: unique_deck_name()
      })
      |> create_deck(user_id)

    deck
  end
end
