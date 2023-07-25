class GlossariesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @glossary = Glossary.create(create_params)
    @current_user.glossaries << @glossary

    render "show", status: 201
  end

  def show
    @glossary = Glossary.find_by(id: params[:id])
  end

  def delete
    # archive
    # maybe need
  end

  private

  def create_params
    params.permit(:title, :content).merge(owner_id: @current_user.id)
  end

  def update_params
    params.permit(:title, :content)
  end
end
