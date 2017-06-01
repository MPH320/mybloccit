class FavoritesController < ApplicationController
    before_action :require_sign_in
 
   def create
       
    if params[:post_id].present?
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.build(post: post)
    else
        sponsored_post = SponsoredPost.find(params[:sponsored_post_id])
        favorite = current_user.favorites.build(sponsored_post: sponsored_post)
    end

    
 
     if favorite.save
       flash[:notice] = "Post favorited."
     else
       flash[:alert] = "Favoriting failed."
     end
 
     if params[:post_id].present?
        redirect_to [post.topic, post]
    else
        redirect_to [sponsored_post.topic, sponsored_post]
    end
   end
   
   def destroy
     
     if params[:post_id].present?
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.find(params[:id])
    else
        sponsored_post = SponsoredPost.find(params[:sponsored_post_id])
        favorite = current_user.favorites.find(params[:id])
    end
     
 
     if favorite.destroy
       flash[:notice] = "Post unfavorited."
     else
       flash[:alert] = "Unfavoriting failed."
     end
        if params[:post_id].present?
            redirect_to [post.topic, post]
        else
            redirect_to [sponsored_post.topic, sponsored_post]
        end
   end
end
