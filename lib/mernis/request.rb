# encoding: utf-8

require 'savon'

class Request
  # Initialize params.
  def initialize(id_number, first_name, last_name, birth_year, version, open_timeout, read_timeout, log, wsdl)
    @id_number = id_number
    @first_name = first_name
    @last_name = last_name
    @birth_year = birth_year
    @version = version
    @open_timeout = open_timeout
    @read_timeout = read_timeout
    @log = log
    @wsdl = wsdl
  end

  # Initialize the SOAP client
  def sorgula
    kps_client = Savon.client(
      wsdl: @wsdl,
      soap_version: @version,
      open_timeout: @open_timeout,
      read_timeout: @read_timeout,
      log: @log
    )

    # Create message pattern
    message = {
      'TCKimlikNo' => @id_number.to_s,
      'Ad' => UnicodeUtils.upcase(@first_name, :tr),
      'Soyad' => UnicodeUtils.upcase(@last_name, :tr),
      'DogumYili' => @birth_year.to_s
    }

    # Make the SOAP request and handle errors.
    result = { status: nil }
    begin
      response = kps_client.call(:tc_kimlik_no_dogrula, message: message)
    rescue Savon::SOAPFault => error
      result[:error_msg] = "SOAP fault. Error: #{error}"
      return result
    rescue Savon::HTTPError => error
      result[:error_msg] = "HTTP connection error. Error: #{error}"
      return result
    end

    # Get the SOAP response and handle errors.
    begin
      bool_value = response.body[:tc_kimlik_no_dogrula_response][:tc_kimlik_no_dogrula_result]
      unless bool_value
        result[:error_msg] = "Girmiş olduğunuz bilgiler hatalı!"
      end
      result[:status] = bool_value
    rescue Savon::InvalidResponseError => error
      result[:error_msg] = "Not a valid response! Error: #{error}"
    end
    return result
  end
end
