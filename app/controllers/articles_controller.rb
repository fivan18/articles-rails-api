class ArticlesController < ApplicationController
  include Paginable
  skip_before_action :authorize!, only: %i[index show]

  def index
    paginated = paginate(Article.recent)
    render_collection(paginated)
  end

  def show
    article = Article.find(params[:id])
    render json: serializer.new(article)
  end

  def create
    article = current_user.articles.build(article_params)
    article.save!
    render json: serializer.new(article), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: article.errors }, status: :unprocessable_entity
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
    render json: serializer.new(article), status: :ok
  rescue ActiveRecord::RecordNotFound
    authorization_error
  rescue ActiveRecord::RecordInvalid
    render json: { errors: article.errors }, status: :unprocessable_entity
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    head :no_content
  rescue StandardError
    authorization_error
  end

  def serializer
    ArticleSerializer
  end

  private

  def article_params
    params.require(:data).require(:attributes)
      .permit(:title, :content, :slug) ||
      ActionController::Parameters.new
  end
end
