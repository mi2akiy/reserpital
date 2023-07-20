class Admin::HospitalsController < ApplicationController
  def index
    @hospitals = Hospital.all
  end

  def new
    @hospital = Hospital.new
  end

  def confirm
    @hospital = Hospital.new(hospital_params)
    @clinical_departments = ClinicalDepartment.all
  end

  def create
    @hospital = Hospital.new(hospital_params)
    @hospital.save
    params[:clinical_department_ids].shift
    params[:clinical_department_ids].each do |clinical_department_id|
    @hospital.clinical_department_managers.create!(clinical_department_id: clinical_department_id )
    end
    redirect_to admin_hospital_path(@hospital)
  end

  def destroy
    @hospital = Hospital.find(params[:id])
    @clinical_departments = ClinicalDepartments.all
    @hospital.destroy
    @clinical_departments.destroy
    redirect_to admin_homes_top
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def edit
  end

private

  def hospital_params
     params.permit(:hospital_image, :name, :clinical_department_id, :telephone_number, :postal_code, :address, :am_start_time, :am_end_time, :pm_start_time, :pm_end_time, :monday_am, :monday_pm, :tuesday_am, :tuesday_pm, :wednesday_am, :wednesday_pm, :thursday_am, :thursday_pm, :friday_am, :friday_pm, :saturday_am, :saturday_pm, :sunday_am, :sunday_pm, :holiday_am, :holiday_pm, :home_page)
  end
end
