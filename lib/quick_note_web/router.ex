defmodule QuickNoteWeb.Router do
  use QuickNoteWeb, :router

  import QuickNoteWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {QuickNoteWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuickNoteWeb do
    pipe_through :browser

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuickNoteWeb do
  #   pipe_through :api
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", QuickNoteWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", QuickNoteWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/profile", UserProfileController, :index
    delete "/users/profile", UserProfileController, :delete
    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/users/folders", UserFoldersLive, :index
    live "/users/folders/new", UserFoldersLive, :new
    live "/users/folders/:folder_id", UserFolderDetailLive, :index
    live "/users/folders/:folder_id/new", UserFolderDetailLive, :new
    live "/users/folders/:folder_id/edit", UserFolderDetailLive, :edit
    live "/users/folders/:folder_id/notes/:note_id", UserNoteLive, :index
    live "/users/folders/:folder_id/notes/:note_id/edit", UserNoteLive, :edit
    live "/users/folders/:folder_id/notes/:note_id/delete", UserNoteLive, :delete

    # resources "/users/folders", UserFoldersController
    # get "/users/folders/:id/notes", UserNotesController, :new
    # post "/users/folders/:id/notes", UserNotesController, :create
    # get "/users/folders/:id/notes/:note_id", UserNotesController, :show
    # get "/users/folders/:id/notes/:note_id/edit", UserNotesController, :edit
    # put "/users/folders/:id/notes/:note_id", UserNotesController, :update
    # delete "/users/folders/:id/notes/:note_id", UserNotesController, :delete
  end

  scope "/", QuickNoteWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
