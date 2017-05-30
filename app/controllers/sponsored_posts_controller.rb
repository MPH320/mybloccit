include Faker

class SponsoredPostsController  < ApplicationController

 before_action :require_sign_in, except: :show

 def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = @topic.sponsored_posts.build(sponsored_post_params)
    @sponsored_post.user = current_user

    if @sponsored_post.save
      flash[:notice] = 'Sponsored Post was saved.'
      redirect_to [@topic, @sponsored_post]
    else
      flash.now[:alert] = 'There was an error saving the Sponsored Post. Please try again.'
      render :new
    end
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.assign_attributes(sponsored_post_params)

    if @sponsored_post.save
      flash[:notice] = 'Sponsored Post was updated.'
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = 'There was an error saving the Sponsored Post. Please try again.'
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = 'There was an error deleting the Sponsored Post.'
      render :show
    end
  end
  private
 
   def sponsored_post_params
     params.require(:sponsored_post).permit(:title, :body, :price)
   end
end
