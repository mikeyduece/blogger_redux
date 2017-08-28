class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  def index
    @articles = Article.all
  end
  
  def show
    @comment = Comment.new
    # I don't know why we use `.new` instead of `@article.comments.new`
    # bc then we'd have to call save as well here which is preferably done in the
    # appropriate controller?
    @comment.article_id = @article.id
  end
  
  def new
    @article = Article.new
    @comment = Comment.new
  end
  
  def create
    @article = Article.create(article_params)
    flash.notice = "Article '#{@article.title} Updated!'"
    redirect_to article_path(@article)
  end
  
  def edit
  end
  
  def update
    @article.update(article_params)
    redirect_to article_path(@article)
  end
  
  def destroy
    @article.destroy
    redirect_to articles_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  def set_article
    @article = Article.find(params[:id])
  end
end
