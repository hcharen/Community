class PostsController < ApplicationController


   def index
     @posts = Post.all
   end

   def show
     @post = Post.find(params[:id])
     @posts = Post.all
   end

   def new
     @post = Post.new
   end

   def edit
     @post = Post.find(params[:id])
   end

   def create
     @post = Post.create(post_params)

     if @post.save
       redirect_to @post
     else
       render 'new'
     end
   end

   def update
     @post = Post.find(params[:id])

     if @post.update(post_params)
       redirect_to posts_path
     else
       redirect_to edit_post_path(@post)
     end
   end

   def destroy
     @post = Post.find(params[:id])
     @post.destroy

     redirect_to posts_path
   end

   private

   def post_params
     params.require(:post).permit(:caption, :text, :image)
   end

  def set_post
    @post = Post.find(params[:id])
  end


end
