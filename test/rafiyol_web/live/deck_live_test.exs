defmodule RafiyolWeb.DeckLiveTest do
  use RafiyolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rafiyol.AccountsFixtures
  import Rafiyol.DecksFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_deck(params) do
    deck = deck_fixture(params.user.id)
    params
    |> Map.put(:deck, deck)
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_deck]

    test "lists all decks", %{conn: conn, deck: deck} do
      {:ok, _index_live, html} = live(conn, Routes.deck_index_path(conn, :index))

      assert html =~ "Listing Decks"
      assert html =~ deck.name
    end

    test "saves new deck", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.deck_index_path(conn, :index))

      assert index_live |> element("a", "New Deck") |> render_click() =~
               "New Deck"

      assert_patch(index_live, Routes.deck_index_path(conn, :new))

      assert index_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deck-form", deck: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deck_index_path(conn, :index))

      assert html =~ "Deck created successfully"
      assert html =~ "some name"
    end

    test "updates deck in listing", %{conn: conn, deck: deck} do
      {:ok, index_live, _html} = live(conn, Routes.deck_index_path(conn, :index))

      assert index_live |> element("#deck-#{deck.id} a", "Edit") |> render_click() =~
               "Edit Deck"

      assert_patch(index_live, Routes.deck_index_path(conn, :edit, deck))

      assert index_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deck-form", deck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deck_index_path(conn, :index))

      assert html =~ "Deck updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes deck in listing", %{conn: conn, deck: deck} do
      {:ok, index_live, _html} = live(conn, Routes.deck_index_path(conn, :index))

      assert index_live |> element("#deck-#{deck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#deck-#{deck.id}")
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_deck]

    test "displays deck", %{conn: conn, deck: deck} do
      {:ok, _show_live, html} = live(conn, Routes.deck_show_path(conn, :show, deck))

      assert html =~ "Show Deck"
      assert html =~ deck.name
    end

    test "updates deck within modal", %{conn: conn, deck: deck} do
      {:ok, show_live, _html} = live(conn, Routes.deck_show_path(conn, :show, deck))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deck"

      assert_patch(show_live, Routes.deck_show_path(conn, :edit, deck))

      assert show_live
             |> form("#deck-form", deck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#deck-form", deck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deck_show_path(conn, :show, deck))

      assert html =~ "Deck updated successfully"
      assert html =~ "some updated name"
    end
  end
end
