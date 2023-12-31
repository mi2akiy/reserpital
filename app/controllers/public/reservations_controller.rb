class Public::ReservationsController < ApplicationController
  before_action :authenticate_end_user
  before_action :is_matching_login_end_user, only: [:cancel]

  def create
    @reservation = current_end_user.reservations.new(hospital_id: params[:hospital_id], date: Date.today,
                                                     time: Time.now)
    @reservation.end_user = current_end_user
    if @reservation.save
      redirect_to public_hospital_reservations_conmplete_path
    else
      @hospital = Hospital.find(params[:hospital_id])
      render template: 'public/hospitals/show'
    end
  end

  def complete
    @hospital = Hospital.find(params[:hospital_id])
  end

  def cancel
    @reservation = Reservation.find(params[:id])
    @reservation.status = 'cancel'
    @reservation.save(context: :skip_end_user_has_no_pending_appointments)
    redirect_to reserved_hospitals_public_end_users_path
  end

  # def show
  #   @hospital = Hospital.find(params[:hospital_id])
  # end

  private

  def authenticate_end_user
    return if end_user_signed_in?

    redirect_to new_end_user_session_path
  end

  def reservation_params
    params.require(:reservation).permit(:date, :time, :hospital_id)
  end

  def is_matching_login_end_user
    reservation = Reservation.find(params[:id])
    return if reservation.end_user.id == current_end_user.id

    redirect_to public_end_users_path
  end
end
