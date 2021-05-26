class PostsController < ApplicationController

    def index
        @posts = Post.all
        @post = Post.new #=> uncomment this when you neeed it
    end

    def new
        @post = Post.new
    end 

    def create
        @post = Post.new(post_params)

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
