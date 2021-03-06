defmodule TorobBackendWeb.Router do
  use TorobBackendWeb, :router
  alias TorobBackend.Accounts.AuthPipeline

  pipeline :api do
    plug :accepts, ["json"]
  end
  pipeline :jwt_authenticated do
    plug AuthPipeline
  end

  scope "/api", TorobBackendWeb do
    pipe_through :api
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    get "/log_out", UserController, :log_out
    get "/category", CategoryController, :index

    get "/users/:id", UserController, :show
    get "/users/", UserController, :index

    get "/shops/:id", ShopController, :show
    get "/shops/", ShopController, :index

    get "/models/:id", ModelController, :show
    get "/models/", ModelController, :index
    get "/models/:word", ModelController, :search

    get "/products/:id", ProductController, :show
    get "/products/", ProductController, :index

    get "/category/:id", CategoryController, :show
    get "/category/", CategoryController, :index

    get "/subcategory/:id", SubcategoryController, :show
    get "/subcategory/", SubcategoryController, :index

    get "/brand/:id", BrandController, :show
    get "/brand/", BrandController, :index

    get "/report/:id", ReportController, :show
    get "/report/", ReportController, :index

    get "/like/:id", LikeController, :show
    get "/like/", LikeController, :index

  end

  scope "/api", TorobBackendWeb do
    pipe_through [:api , :jwt_authenticated]
#    pipe_through [:api]

    resources "/users" , UserController ,except: [:new , :edit , :create,:show ,:index]
    resources "/shops" , ShopController ,except: [:new , :edit ,:show ,:index]
    resources "/models" , ModelController ,except: [:new , :edit ,:show ,:index]
    resources "/products" , ProductController ,except: [:new , :edit ,:show ,:index]
    resources "/category" , CategoryController ,except: [:new , :edit, :index ,:show ]
    resources "/subcategory" , SubcategoryController ,except: [:new , :edit ,:show ,:index]
    resources "/brand" , BrandController ,except: [:new , :edit ,:show ,:index]
    resources "/report" , ReportController ,except: [:new , :edit ,:show ,:index]
    resources "/like" , LikeController ,except: [:new , :edit ,:show ,:index]
#    resources "/reservations" , ReservationController ,except: [:new , :edit , :create ]
#    post "/reservations/:id", ReservationController, :create

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TorobBackendWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
#      pipe_through [:fetch_session, :protect_from_forgery]
#
#      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
