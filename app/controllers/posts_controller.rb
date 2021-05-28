class PostsController < ApplicationController
    # before_action :set_post
    # before_action :authenticate_user!, except: [:index, :show]


    def index
        @posts = Post.all
        @users = User.all
        @post = Post.new #=> uncomment this when you neeed it
    end

    def new
        @post = current_user.posts.build
    end 

    def create
        @post = current_user.posts.build(post_params)

        #respond_to allows you to respond in different formats, such as html, json
        respond_to do |format|
            if @post.save
                format.html { redirect_to root_path, notice: "Post Created Successfully"}
            else
                format.html { render :new, notice: "Post was not created, try again"} #try to understand what @post.errors would do, or status: unprocessable_entity does
            end
        end


    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        respond_to do |format|
            if @post.update(post_params)
                format.html {redirect_to root_path, notice: "Post Updated Successfully"}
            else
                format.html {render :edit, notice: "Post was not updated, try again"}#try to understand what @post.errors would do, or status: unprocessable_entity does
            end
        end

    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        respond_to do |format|
            format.html {
                redirect_to root_path, notice: "Post was successfully destroyed."
            }
        end

    end

    private

    def post_params
        params.require(:post).permit(:post,:title)
    end


end
