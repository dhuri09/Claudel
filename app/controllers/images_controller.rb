class ImagesController < ApplicationController
  
  def index
  end
  
  def create
    @image = Image.new(params[:image])
    respond_to do |format|
      if @image.save
        format.html { redirect_to "/works/#{@image.work_id}/edit/images" }
      else
        format.html { redirect_to "/works/#{@image.work_id}/edit/images" }
      end
    end
  end
  
  def destroy
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.destroy
        format.html { redirect_to "/works/#{@image.work_id}/edit/images" }
      else
        format.html { redirect_to "/works/#{@image.work_id}/edit/images" }
      end
    end
  end
  
end
