class DwellingsController < ApplicationController
  before_action :find_development

  def index
    @dwellings = @development.dwellings
  end

  def new
    @dwelling = @development.dwellings.build
  end

  def create
    @dwelling = @development.dwellings.build(dwelling_params)
    if @dwelling.save
      flash[:notice] = 'Dwelling successfully added'
      redirect_to development_dwellings_path(@development)
    else
      render action: :new
    end
  end

  def edit
    @dwelling = @development.dwellings.find(params[:id])
  end

  def update
    @dwelling = @development.dwellings.find(params[:id])
    if @dwelling.update(dwelling_params)
      flash[:notice] = 'Dwelling successfully saved'
      redirect_to development_dwellings_path(@development)
    else
      render action: :edit
    end
  end

  def delete
    @dwelling = @development.dwellings.find(params[:id])
  end

  def destroy
    @dwelling = @development.dwellings.find(params[:id])
    @dwelling.audit_comment = params[:dwelling][:audit_comment] if params[:dwelling]
    if @dwelling.destroy
      flash[:notice] = 'Dwelling deleted'
      redirect_to development_dwellings_path(@development)
    else
      render action: :delete
    end
  end

  private

  def find_development
    @development = Development.find(params[:development_id])
  end

  def dwelling_params
    params.require(:dwelling).permit(
      :reference_id,
      :tenure,
      :habitable_rooms,
      :bedrooms,
      :audit_comment,
      :audit_planning_application_id
    )
  end
  end
end
