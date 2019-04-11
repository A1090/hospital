class MedicinesController < ApplicationController
  before_action :load_medicine, only: %i[show edit update delete]
  before_action :load_medicines, only: %i[list]

  def list
    @medicines
  end

  def show
    @medicine
  end

  def new
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new(medicine_params)
  
    if @medicine.save
      redirect_to :action => 'list'
    else
      @error = @medicine.errors
      render file: "app/views/error"
    end
  end

  def medicine_params
    params.require(:medicine).permit(:name, :company, :substances)
  end

  def edit
    @medicine
  end

  def update
    if @medicine.update_attributes(medicine_params)
      redirect_to :action => 'show', :id => @medicine
    else
      @error = @medicine.errors
      render file: "app/views/error"
    end
  end

  def delete
    if current_user.admin
      @medicine.destroy
      redirect_to :action => 'list'
    else
      @error = "The current user is not an admin."
    end
  end

  private

  def load_medicine
    @medicine = Medicine.find(params[:id])
  end

  def load_medicines
    @medicines = Medicine.all.order(created_at: :desc)
  end
end
