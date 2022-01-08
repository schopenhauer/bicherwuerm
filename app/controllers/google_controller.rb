class GoogleController < ApplicationController
  before_action :authenticate_user!
  before_action :valid_credentials?

  def search
    if valid_credentials?
      @images = params[:q] ? query(params[:q]) : nil
      render 'google/search'
    else
      render 'google/credentials'
    end
  end

  private

  def valid_credentials?
    Rails.application.credentials.google.client_cx && Rails.application.credentials.google.client_key
  end

  def query(q)
    response = HTTP.get(
      'https://www.googleapis.com/customsearch/v1',
      params: {
        v: '1.0',
        q: q,
        searchType: 'image',
        fields: 'items',
        cx: Rails.application.credentials.google.client_cx,
        key: Rails.application.credentials.google.client_key
      }
    )
    data = MultiJson.load(response.body)

    if response.status == 200
      @images = data['items'] if data['items']
    else
      @images = nil
    end
  end

end
