class FavoriteMailer < ApplicationMailer
  default from: "michelangelo.ph@gmail.com"
  
  def new_comment(user, post, comment)
 
     headers["Message-ID"] = "<comments/#{comment.id}@mikesbloccit>"
     headers["In-Reply-To"] = "<post/#{post.id}@mikesbloccit>"
     headers["References"] = "<post/#{post.id}@mikesbloccit>"
 
     @user = user
     @post = post
     @comment = comment

     mail(to: user.email, subject: "New comment on #{post.title}")
   end
   
   def new_commentSP(user, sponsored_post, comment)
 
     headers["Message-ID"] = "<comments/#{comment.id}@mikesbloccit>"
     headers["In-Reply-To"] = "<sponsored_post/#{sponsored_post.id}@mikesbloccit>"
     headers["References"] = "<sponsored_post/#{sponsored_post.id}@mikesbloccit>"
 
     @user = user
     @sponsored_post = sponsored_post
     @comment = comment

     mail(to: user.email, subject: "New comment on #{sponsored_post.title}")
   end
 
 def new_post(user, post)
     headers['Message-ID'] = "<post/#{post.id}@your-app-name.example>"
     headers['In-Reply-To'] = "<post/#{post.id}@your-app-name.example>"
     headers['References'] = "<post/#{post.id}@your-app-name.example>"
 
     @user = user
     @post = post
 
     mail(to: user.email, subject: "You created a new post: #{post.title}")
   end
end