defmodule SbWeb.PromotionController do
  use SbWeb, :controller

  alias Sb.Cases
  alias Sb.Cases.Promotion

  action_fallback SbWeb.FallbackController

  def index(conn, _params) do
    IO.inspect(_params)

    case _params["state"] do
      val ->
        promotions = Cases.list_promotions_by_state(String.to_existing_atom(val))
        render(conn, "index.json", promotions: promotions)

      nil ->
        promotions = Cases.list_promotions()
        render(conn, "index.json", promotions: promotions)
    end
  end

  def index(conn, %{"state" => state}) do
    promotions = Cases.list_promotions_by_state(state)
    render(conn, "index.json", promotions: promotions)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    code_gen = Promotion.randomizer(4, :alpha)

    case Cases.get_event!(promotion_params["event_id"]) do
      event ->
        {{y, m, d}, {h, mi, s}} = NaiveDateTime.to_erl(event.end_event)
        h2 = h - 1
        {:ok, expiration_gen} = NaiveDateTime.new(y, m, d, h2, mi, s)

        promotion_params2 =
          Map.merge(promotion_params, %{
            "code" => code_gen,
            "expiration" => expiration_gen,
            "state" => true
          })

        IO.inspect(promotion_params2)

        with {:ok, %Promotion{} = promotion} <- Cases.create_promotion(promotion_params2) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.promotion_path(conn, :show, promotion))
          |> render("show.json", promotion: promotion)
        end

      NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render("not_found_event.json")
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = Cases.get_promotion!(id)
    render(conn, "show.json", promotion: promotion)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = Cases.get_promotion!(id)

    with {:ok, %Promotion{} = promotion} <- Cases.update_promotion(promotion, promotion_params) do
      render(conn, "show.json", promotion: promotion)
    end
  end

  def delete(conn, %{"id" => id}) do
    promotion = Cases.get_promotion!(id)

    with {:ok, %Promotion{}} <- Cases.delete_promotion(promotion) do
      send_resp(conn, :no_content, "")
    end
  end
end
