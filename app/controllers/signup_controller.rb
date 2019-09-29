class SignupController < ApplicationController
  def index
  end

  def registration
    @user = User.new
  end

  def sms_confirmation
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:birth_yyyy_id] = user_params[:birth_yyyy_id]
    session[:birth_mm_id] = user_params[:birth_mm_id]
    session[:birth_dd_id] = user_params[:birth_dd_id]
    @user = User.new # 新規インスタンス作成
  end

  def sms_confirmation_sms
    session[:phone_num] = user_params[:phone_num]
    @user = User.new # 新規インスタンス作成
  end

  def address
    session[:authentication_num] = user_params[:authentication_num]
    @user = User.new # 新規インスタンス作成
  end

  def credit_card
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:zip_code1] = user_params[:zip_code1]
    session[:prefecture_id] = user_params[:prefecture_id]
    session[:city] = user_params[:city]
    session[:address1] = user_params[:address1]
    session[:address2] = user_params[:address2]
    session[:telephone] = user_params[:telephone]
    @user = User.new # 新規インスタンス作成
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  def login
  end

  def create
    session[:payment_card_no] = user_params[:payment_card_no]
    session[:paymentmonth_id] = user_params[:paymentmonth_id]
    session[:paymentyear_id] = user_params[:paymentyear_id]
    session[:payment_card_security_code] = user_params[:payment_card_security_code]
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      first_name: session[:first_name],
      last_name: session[:last_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      birth_yyyy_id: session[:birth_yyyy_id],
      birth_mm_id: session[:birth_mm_id],
      birth_dd_id: session[:birth_dd_id],
      phone_num: session[:phone_num],
      authentication_num: session[:authentication_num],
      zip_code1: session[:zip_code1],
      prefecture_id: session[:prefecture_id],
      city: session[:city],
      address1: session[:address1],
      address2: session[:address2],
      telephone: session[:telephone],
      payment_card_no: session[:payment_card_no],
      paymentmonth_id: session[:paymentmonth_id],
      paymentyear_id: session[:paymentyear_id],
      payment_card_security_code: session[:payment_card_security_code]
    )
    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to signup_done_path
    else
      render '/signup/registration'
    end
  end
end

private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :first_name_kana,
      :last_name_kana,
      :birth_yyyy_id,
      :birth_mm_id,
      :birth_dd_id,
      :phone_num,
      :authentication_num,
      :zip_code1,
      :prefecture_id,
      :city,
      :address1,
      :address2,#任意
      :telephone,#任意
      :payment_card_no,
      :paymentmonth_id,
      :paymentyear_id,
      :payment_card_security_code
    )
  end