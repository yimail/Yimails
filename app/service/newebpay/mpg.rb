module Newebpay
  class Mpg
    attr_accessor :info

    def initialize
      @key = ENV["newebpay_key"]
      @iv = ENV["newebpay_iv"]
      @merchant_id = ENV["merchant_id"]
      @info = {}
      set_info
    end

    def form_info
      {
        MerchantID: @merchant_id,
        TradeInfo: trade_info,
        TradeSha: trade_sha,
        Version: "1.5"
      }
    end

    private
    # 以下為必填資料
    def set_info
      info[:MerchantID] = @merchant_id
      info[:MerchantOrderNo] = yimailsOrderNo
      info[:Amt] = "60"
      info[:ItemDesc] = '365天~天天yimail'
      info[:Email] = ''
      info[:TimeStamp] = Time.now.to_i.to_s
      info[:RespondType] = "JSON"
      info[:Version] = "1.5"
      info[:ReturnURL] = 'https://yimails.com/orders/payment_response'
      info[:NotifyURL] = ''
      info[:LoginType] = 0
      info[:CREDIT] = 1
      info[:VACC] = 0
      info[:TradeLimit] = 300
    end

    # 將商品編號設置年月日時分星期+亂碼7位數
    def yimailsOrderNo
      yimails = "yimails#{Time.current.strftime("%Y%m%d%H%M%w")}"
      random = [*'a'..'z', *'A'..'Z', *'0'..'9']
      return yimails + random.sample(7).join
    end

    def trade_info
      # AES256加密後資訊
      aes_encode(url_encoded_query_string)
    end

    def trade_sha
      # SHA加密後資訊
      sha256_encode(@key, @iv, trade_info)
    end
    
    def url_encoded_query_string
      # 將加密後的內容轉為query string
      URI.encode_www_form(info)
    end

    def aes_encode(string)
      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = @key
      cipher.iv = @iv
      cipher.padding = 0
      padding_data = add_padding(string)
      encrypted = cipher.update(padding_data) + cipher.final
      encrypted.unpack('H*').first
    end

    def add_padding(data, block_size = 32)
      pad = block_size - (data.length % block_size)
      data + (pad.chr * pad)
    end 

    # SHA加密
    def sha256_encode(key, iv, trade_info)
      encode_string = "HashKey=#{key}&#{trade_info}&HashIV=#{iv}"
      Digest::SHA256.hexdigest(encode_string).upcase
    end
  end
end