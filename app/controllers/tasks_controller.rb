class TasksController < ApplicationController
	def index
		#@tasks = Task.where(:done => false).order("due_date DESC")
		@tasks = Task.undone.paginate(:page => params[:page], :per_page => 5)
	end

	def done
		@tasks = Task.done.paginate(:page => params[:page])
		#@tasks = Task.where(:done => true).order("due_date")
		render :index
	end

	def show
		@tasks = Task.find(params[:id])
	end

	def new
		@tasks = Task.new
	end

	def create
		@tasks = Task.create(params[:task])
		redirect_to @tasks
	end

	def edit
		@tasks = Task.find(params[:id])	
	end

	def update
		@tasks = Task.find(params[:id])
		@tasks.update_attributes(params[:task])
		redirect_to @tasks
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to :tasks
	end

	def finish
		@task = Task.find(params[:id])
		@task.update_attribute(:done, true)
		redirect_to :back
	end

	def restart
		@task = Task.find(params[:id])
		@task.update_attribute(:done, false)
		redirect_to :back
		
	end

	def search
		@tasks = Task.undone
		@tasks = @tasks.search(params[:query]) if params[:query].present?
		@tasks = @tasks.paginate(:page => params[:page])
		render :index
	end
end
