defmodule Rafiyol.DecksTest do
  use Rafiyol.DataCase

  alias Rafiyol.Decks

  describe "decks" do
    alias Rafiyol.Decks.Deck

    import Rafiyol.AccountsFixtures
    import Rafiyol.DecksFixtures

    @invalid_attrs %{name: nil}

    test "list_decks/1 returns all user's decks" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      assert Decks.list_decks(user.id) == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{name: "some name"}

      user = user_fixture()

      assert {:ok, %Deck{} = deck} = Decks.create_deck(user.id, valid_attrs)
      assert deck.name == "some name"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      user = user_fixture()
      deck = deck_fixture(user.id)
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end
end
