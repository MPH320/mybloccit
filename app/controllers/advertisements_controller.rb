class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end
  
  def edit
    @advertisement = Advertisement.find(params[:id])
  end

  def create
     @advertisement = Advertisement.new
     @advertisement.title = params[:advertisement][:title]
     @advertisement.body = params[:advertisement][:body]
     @advertisement.url = params[:advertisement][:url]
     @advertisement.price = params[:advertisement][:price]
 
     if @advertisement.save
       flash[:notice] = "Advertisement was saved."
       redirect_to @advertisement
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
    end
    
    def update
     @advertisement = Advertisement.find(params[:id])
     @advertisement.title = params[:advertisement][:title]
     @advertisement.body = params[:advertisement][:body]
     @advertisement.url = params[:advertisement][:url]
     @advertisement.price = params[:advertisement][:price]
 
     if @advertisement.save
       flash[:notice] = "Advertisement was updated."
       redirect_to @advertisement
     else
       flash.now[:alert] = "There was an error saving the advertisement. Please try again."
       render :edit
     end
   end
   
   def destroy
     @advertisement = Advertisement.find(params[:id])
 
     if @advertisement.destroy
       flash[:notice] = "\"#{@advertisement.title}\" was deleted successfully."
       redirect_to advertisements_path
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end
end
