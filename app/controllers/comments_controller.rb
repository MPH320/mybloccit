class CommentsController < ApplicationController
    #before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
 
   def create
    
    
    if params[:post_id].present?
        @post = Post.find(params[:post_id]) 
        comment = @post.comments.new(comment_params)
    else
        @sponsored_post = SponsoredPost.find(params[:sponsored_post_id])
        comment = @sponsored_post.comments.new(comment_params)
    end
    
    if current_user.present?
        comment.user = current_user
    else
        comment.user = User.first
    end
     
 
     if comment.save
       flash[:notice] = "Comment saved successfully."

        if  params[:post_id].present?
            redirect_to [@post.topic, @post]
        else
            redirect_to [@sponsored_post.topic, @sponsored_post]
        end
       
     else
       flash[:alert] = "Comment failed to save."

        if  params[:post_id].present?
            redirect_to [@post.topic, @post]
        else
            redirect_to [@sponsored_post.topic, @sponsored_post]
        end
     end
   end
   
   
    def destroy
        
        if  params[:post_id].present?
            @post = Post.find(params[:post_id])
            comment = @post.comments.find(params[:id])
        else
            @sponsored_post = SponsoredPost.find(params[:sponsored_post_id])
            comment = @sponsored_post.comments.find(params[:id])
        end
 
     if comment.destroy
       flash[:notice] = "Comment was deleted."
        if  params[:post_id].present?
            redirect_to [@post.topic, @post]
        else
            redirect_to [@sponsored_post.topic, @sponsored_post]
        end
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
        if  params[:post_id].present?
            redirect_to [@post.topic, @post]
        else
            redirect_to [@sponsored_post.topic, @sponsored_post]
        end
     end
   end
 
   private
 

   def comment_params
     params.require(:comment).permit(:body)
   end
   
   def authorize_user
       
       if  params[:post_id].present?
            @post = Post.find(params[:post_id])
        else
            @sponsored_post = SponsoredPost.find(params[:sponsored_post_id])
        end
       
       comment = Comment.find(params[:id])
     
       unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       if  params[:post_id].present?
            redirect_to [comment.post.topic, comment.post]
        else
            redirect_to [comment.sponsored_post.topic, comment.sponsored_post]
        end
     end
   end
end
