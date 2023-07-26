class GlossariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @glossaries = @current_user.glossaries.uniq
  end

  def create
    @glossary = Glossary.create(create_params)
    @current_user.glossaries << @glossary

    render "show", status: 201
  end

  def show
    @glossary = Glossary.find_by(id: params[:id])
  end

  def update
    @glossary = @current_user.glossaries.find_by(id: params[:id])

    if @glossary.nil?
      handle_404(fields: "glossary", model: "Glossary") and return
    end

    if @glossary.update(update_params)
      render "show", status: 200
    else
      @record = @glossary
      render "common/record_error", status: 422
    end
  end

  def add_vocabularies
    @glossary = @current_user.glossaries.find_by(id: params[:id])

    if @glossary.present? && @glossary.can_update?(@current_user)
      @glossary.add_vocabularies(params[:vocabulary_ids])
      handle_ok
    else
      handle_401
    end
  end

  private

  def create_params
    params.permit(:title, :content).merge(owner_id: @current_user.id)
  end

  def update_params
    params.permit(:title, :content)
  end
end
