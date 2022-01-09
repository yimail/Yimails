class LabelsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_label, only:[:show, :edit, :update, :destroy]
  before_action :label_with_order, only:[:index, :new]

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.group.present?
      find_title = Label.find_by_title(@label.group)
      @label[:hierarchy] = "#{find_title[:hierarchy]}/#{@label.title}"
    else
      @label[:hierarchy] = @label.title
    end

    @label[:indentation] = @label[:hierarchy].count"/"
    @label[:display] = "#{'　'*@label.indentation} #{@label.title}"

    if @label.save
      redirect_to labels_path
    else
      render :new
    end
  end

  def show
    @labels = Label.order(:hierarchy)
    @label_folder = Label.order(:hierarchy)
    label = Label.find(params[:id])
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
    @labels_with_order = Label.order(:hierarchy)
  end
end
