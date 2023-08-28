class ProgramsController < ApplicationController
  before_action :find_id, only: [ :show, :update, :destroy ]
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
      program = Program.where("name like '%#{params[:name].strip}%'")
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

  # .....................Show active programs....................
  def show_active_program
    program = Program.where(status: 'active')
    unless program.empty?
      render json: program
    else
      render json: { message: 'No data found...' }
    end
  end

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
end
