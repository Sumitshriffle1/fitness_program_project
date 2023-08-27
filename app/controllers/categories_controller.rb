class CategoriesController < ApplicationController
  before_action :find_id, except: [:index, :create]
  protect_from_forgery

  # ..................Show all categories................... 
  def index
    category=Category.all 
    if category
      render json: category
    else
      render json: { message: "There are no categories available.." }      
    end
  end
  
  # ..................Create category......................
  # def create
  #   category = Category.new(set_params)
  #   if category.save
  #     render json: category
  #   else
  #     render json: { error: category.errors.full_messages }
  #   end
  # end

  def create
    if @current_user.type=="Instructor"
      category = @current_user.categories.new(set_params)
      if category.save
        render json: category
      else
        render json: { error: category.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Only instructors can create categories' }, status: :unauthorized
    end
  end
  
  def update
    if @current_user.type=="Instructor"
      if @category.update(set_params)
        render json: { message: 'Updated successfully', data: @category }
      else
        render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Only instructors can update categories' }, status: :unauthorized
    end
  end
  
  # def create
  #   if @current_user
  #     category = Category.new(set_params)
  #     if category.save
  #       render json: category
  #     else
  #       render json: { error: category.errors.full_messages }
  #     end
  #   else
  #     render json: { message: "You do not have permission to create a category." }
  #   end
  # end
  

  # ..................Update category......................
  # def update
  #   if @category.update(set_params)
  #     render json: { message: 'Updated successfully', data: @category }
  #   else
  #     render json: { message: @category.errors.full_messages }      
  #   end
  # end

  # def update
  #   if @current_user=="Instructor" 
  #     if @category.update(set_params)
  #       render json: { message: 'Updated successfully', data: @category }
  #     else
  #       render json: { message: @category.errors.full_messages }
  #     end
  #   else
  #     render json: { message: "You do not have permission to update this category." }
  #   end
  # end
  
  # ..................Delete category......................
  # def destroy
  #   if @category.destroy
  #     render json: { message: 'Deleted successfully', data: @category }
  #   else
  #     render json: { message: 'No such data exists to be deleted' }      
  #   end
  # end

  def destroy
    if @current_user.type=="Instructor"
      if @category.destroy
        render json: { message: 'Deleted successfully', data: @category }
      else
        render json: { message: 'No such data exists to be deleted' }
      end
    else
      render json: { message: 'Only instructors can delete categories' }, status: :unauthorized
    end
  end
  
  # def destroy
  #   if @current_user=="Instructor" 
  #     if @category.destroy
  #       render json: { message: 'Deleted successfully', data: @category }
  #     else
  #       render json: { message: 'No such data exists to be deleted' }
  #     end
  #   else
  #     render json: { message: "You do not have permission to delete this category." }
  #   end
  # end
  
  # ..................Show category.........................
  def show
    render json: @category
  end

  private 
  def set_params
    params.permit(:category_name)
  end

  def find_id
    @category = Category.find_by_id(params[:id])
    unless @category
      render json: "Id not found.." 
    end   
  end
end
