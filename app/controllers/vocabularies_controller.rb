class VocabulariesController < ApplicationController
  # member controller under GlossariesController
  before_action :authenticate_user!
  before_action :set_glossary

  def index
    @vocabularies = @glossary.vocabularies.include(:sentences)
    # order
  end

  def show
    set_vocabulary
  end

  def sample
    @vocabulary = @glossary.vocabularies.sample

    render "show"
  end

  def mark
    # params[:mark] = true / false
    set_vocabulary
    mark_log = MarkLog.find_or_initialize_by(user: @current_user, vocabulary: @vocabulary)
    mark_log.action = params[:mark] ? "known" : "unknown"
    mark_log.save

    handle_ok
  end

  private

  def set_glossary
    @glossary = @current_user.glossaries.find_by(id: params[:glossary_id])
  end

  def set_vocabulary
    @vocabulary = @glossary.vocabularies.find_by(id: params[:id])
  end
end
