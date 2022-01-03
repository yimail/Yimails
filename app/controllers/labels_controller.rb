class LabelsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_label, only:[:edit, :update, :destroy]

  def index
    @labels = Label.all
  end
  
  def new
    @label = Label.new
    @labels_with_order = Label.all.order(:hierarchy)
  end
  
  def create
    @label = current_user.labels.build(label_params)
    if @label.group.present?
      find_title = Label.find_by_title(@label.group)
      @label[:hierarchy] = "#{find_title[:hierarchy]}/#{@label.title}"
    else
      @label[:hierarchy] = @label.title
    end

    count_space = @label[:hierarchy].count"/"
    @label[:display] = "#{' . '*count_space} #{@label.title}"

    if @label.save
      redirect_to labels_path
    else    
      render :new
    end
  end

  def edit
  end

  def update 
    if @label.update(label_params)
      redirect_to labels_path
    else
      render :edit
    end
  end
  
  def destroy
    @label.destroy
    redirect_to labels_path
  end

  private
  def find_label
    @label = current_user.labels.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:title, :group)
  end
end
