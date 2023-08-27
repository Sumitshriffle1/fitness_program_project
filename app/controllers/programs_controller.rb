class ProgramsController < ApplicationController
  before_action :find_id, only: [ :show, :update, :destroy ]
  before_action :active_program, only: [ :show_active_program, :show_category_wise_programs ]
  protect_from_forgery

  # ...................Show programs....................
  def index
  	program = Program.all
    if program.present?
      render json: program
    else
      render json: { message: "No programs exists" }
    end
  end

  # ...................Create program....................
  def create
    if @current_user.type=="Instructor"
      program = @current_user.programs.new(set_params)
      if program.save
        render json: program
      else
        render json: { errors: program.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You do not have permission to create a program." }, status: :unauthorized
    end
  end
  
  # ..............Show particular program................
  def show
		render json: @program
  end

  # ...................Update program....................
  def update
    if @current_user.type=="Instructor"
      if @program.update(set_params)
        render json: @program
      else
        render json: { errors: @program.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You do not have permission to update this program." }, status: :unauthorized
    end
  end
  

  # .....................Destroy program.....................
  def destroy  
    if @current_user.type=="Instructor"
      if @program.destroy
        render json: { message: 'Deleted successfully' }
      else
        render json: { message: 'Failed to delete the program' }
      end
    else
      render json: { message: 'You do not have permission to delete this program' }, status: :unauthorized
    end
  end
  
  # ..............Search program through name.....................
  def search_program_name
    if params[:name].present?
      program = Program.where('name like ?', '%' + params[:name].strip + '%')
      if program.empty?
        render json: { message: 'No data found...' }
      else
        render json: program
      end
    else
      render json: { message: 'No record found...' }
    end
  end

  # ..............Search program through status.....................
  def search_program_status
    if params[:status].present?
      program = Program.where("status like '%#{params[:status].strip}%'")
      if program.empty?
        render json: { message: 'No data found...' }
      else
        render json: program
      end
    else
      render json: { message: 'No record found...' }
    end
  end

  # .................Delete Customer Program............................
  # def delete_customer_purchase
  #   if params[:program_id].present? && params[:purchase_id].present?
  #     program = @current_user.programs.joins(:purchases).where("programs.id = #{ params[:program_id] } AND purchases.id = #{ params[:purchase_id] }")
  #     if program.empty?
  #       render json: {message: "Record not found"}
  #     else
  #       purchase = Purchase.find(params[:purchase_id])
  #       purchase.destroy
  #       render json: { message: "Purchase deleted successfully" }
  #     end
  #   else
  #     render json: { message: "Record not found" }
  #   end
  # end

  # .................Customer Functionalities....................
  # .....................Show active programs....................
  def show_active_program
  end

  # .....................Show category wise programs.............
  def show_category_wise_programs
  end

  # # ..................Search in purchased Programs.......................
  # def search_in_customer_program
  #   if params[:name].present?
  #     program = Purchase.joins(:program).where("purchases.user_id=#{ @current_user.id } AND name LIKE '%#{ params[:name].strip }%'")
  #     if program.empty?
  #       render json: { error: 'Record not found' }
  #     else
  #       render json: program
  #     end
  #   else
  #     render json: { message: "Please provide required field" }
  #   end
  # end

	private
  def set_params
    params.permit(:name,:status,:price,:user_id,:category_id)
  end

  def find_id
    @program = Program.find_by_id(params[:id])
    unless @program
      render json: "Id not found.." 
    end   
  end

  def active_program
    program = Program.where(status: 'active')
    unless program.empty?
      render json: program
    else
      render json: { message: 'No data found...' }
    end
  end
end
