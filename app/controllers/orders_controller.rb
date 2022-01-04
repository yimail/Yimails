class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:payment_response]

  def payment
    @form_info = Newebpay::Mpg.new.form_info
  end

  def payment_response
    response = Newebpay::MpgResponse.new(params[:TradeInfo])
  end
end
