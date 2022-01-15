class LabelsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_label, only:[:show, :edit, :update, :destroy]
  before_action :label_with_order, only:[:index, :new]

  def index
    @labels = current_user.labels
  end

  def new
    @label = current_user.labels.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.group.present?
      find_title = current_user.labels.find_by_title(@label.group)
      @label[:hierarchy] = "#{find_title[:hierarchy]}/#{@label.title}"
    else
      @label[:hierarchy] = @label.title
    end

    count_space = @label[:hierarchy].count"/"
    @label[:indentation] = count_space*4
    @label[:display] = "#{'　'*count_space} #{@label.title}"

    if @label.save
      redirect_to letters_path
    else
      redirect_to labels_path
    end
  end

  def show
    @labels = current_user.labels.order(:hierarchy)
    @label_folder = current_user.labels.order(:hierarchy)
    label = current_user.labels.find(params[:id])
    @letters = label.letters.order(id: :desc)
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

  def label_with_order
    @labels_with_order = current_user.labels.order(:hierarchy)
  end
end
