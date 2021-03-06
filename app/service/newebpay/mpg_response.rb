module Newebpay
  class MpgResponse
    attr_reader :status, :message, :result, :order_no, :trans_no

    def initialize(params)
      @key = ENV["newebpay_key"]
      @iv = ENV["newebpay_iv"]

      response = decrypy(params)
      @status = response['Status']
      @message = response['Message']
      @result = response['Result']
      @order_no = @result['MerchantOrderNo']
      @trans_no = @result['TradeNo']
      @amt = @result['Amt']
      @pay_time = @result['PayTime']
      @card_last4num = @result['Card4No']
    end

    def success?
      status === 'SUCCESS'
    end

    private
      def decrypy(encrypted_data)
        encrypted_data = [encrypted_data].pack('H*')
        decipher = OpenSSL::Cipher::AES256.new(:CBC)
        decipher.decrypt
        decipher.padding = 0
        decipher.key = @key
        decipher.iv = @iv
        data = decipher.update(encrypted_data) + decipher.final
        raw_data = strippadding(data)
        JSON.parse(raw_data)
      end

      def strippadding(data)
        slast = data[-1].ord
        slastc = slast.chr
        string_match = /#{slastc}{#{slast}}/ =~ data
        if string_match.present?
          data[0, string_match]
        else
          false
        end
      end
  end
end