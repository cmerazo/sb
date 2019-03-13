defmodule SbWeb.Router do
  use SbWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SbWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/clients", ClientController, except: [:new, :edit]
    resources "/events", EventController, except: [:new, :edit]
    resources "/promotions", PromotionController, except: [:new, :edit]
    resources "/rides", RideController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  scope "/v1", SbWeb do
    pipe_through :api
    resources "/clients", ClientController, except: [:new, :edit]
    resources "/events", EventController, except: [:new, :edit]
    resources "/promotions", PromotionController, except: [:new, :edit]
    resources "/rides", RideController, except: [:new, :edit]
  end
end
