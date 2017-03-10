class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # GET /blogs
  def index
    @blogs = Blog.all
  end
  # GET /blogs/1
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
      @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blog_path(@blog, locale:I18n.locale), notice: t(".blog_succes")
    else
      render :new
    end
  end
  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog, locale:I18n.locale), notice: t(".blog_updated")
    else
      render :edit
    end
  end
  # DELETE /blogs/1
  def destroy
    @blog.destroy
    redirect_to blogs_url(locale: I18n.locale), notice: notice: t(".blog_destroyed")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:blog).permit(:title, :body)
    end
end
