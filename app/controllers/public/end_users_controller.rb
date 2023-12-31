class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(current_end_user.id)
  end

  def edit
    @end_user = EndUser.find(current_end_user.id)
  end

  def update
    @end_user = EndUser.find(current_end_user.id)
    @end_user.update(end_user_params)
    redirect_to public_end_users_path
  end

  def unsubscribe; end

  def withdrawal
    @end_user = EndUser.find(current_end_user.id)
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to root_path
  end

  # 診察予約履歴一覧
  def reserved_hospitals
    @reservations = current_end_user.reservations.order(id: :desc)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :sex, :birthday,
                                     :email, :telephone_number, :postal_code, :address)
  end

  def reservation_params
    params.require(:reservation).permit(:status)
  end
end
