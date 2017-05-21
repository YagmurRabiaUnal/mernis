require 'spec_helper'
require 'savon'
require 'mernis'
require 'unicode_utils'

describe 'Request' do
  before(:each) do
    @client = Savon.client(
      wsdl: 'https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx?WSDL',
      soap_version: 2,
      open_timeout: 60,
      read_timeout: 60,
      log: false
    )
  end

  it 'returns true with correct identity' do
    response = @client.call(:tc_kimlik_no_dogrula, message:
    {
      'TCKimlikNo' => '11311152982',
      'Ad' => UnicodeUtils.upcase('Kuzey Tüner', :tr),
      'Soyad' => UnicodeUtils.upcase('Şenkul', :tr),
      'DogumYili' => '2014'
    })
    bool_value = response.body[:tc_kimlik_no_dogrula_response][:tc_kimlik_no_dogrula_result]
    expect(bool_value).to equal(true)
  end

  it 'returns true with downcase characters' do
    response = @client.call(:tc_kimlik_no_dogrula, message:
    {
      'TCKimlikNo' => '11311152982',
      'Ad' => UnicodeUtils.upcase('kuzey tüner', :tr),
      'Soyad' => UnicodeUtils.upcase('şenkul', :tr),
      'DogumYili' => '2014'
    })
    bool_value = response.body[:tc_kimlik_no_dogrula_response][:tc_kimlik_no_dogrula_result]
    expect(bool_value).to equal(true)
  end

  it 'returns true with upcase characters' do
    response = @client.call(:tc_kimlik_no_dogrula, message:
    {
      'TCKimlikNo' => '11311152982',
      'Ad' => UnicodeUtils.upcase('KUZEY TÜNER', :tr),
      'Soyad' => UnicodeUtils.upcase('ŞENKUL', :tr),
      'DogumYili' => '2014'
    })
    bool_value = response.body[:tc_kimlik_no_dogrula_response][:tc_kimlik_no_dogrula_result]
    expect(bool_value).to equal(true)
  end

  it 'returns false with incorrect identity' do
    response = @client.call(:tc_kimlik_no_dogrula, message:
    {
      'TCKimlikNo' => '11311152982',
      'Ad' => UnicodeUtils.upcase('Kuzey', :tr),
      'Soyad' => UnicodeUtils.upcase('Şenkul', :tr),
      'DogumYili' => '2014'
    })
    bool_value = response.body[:tc_kimlik_no_dogrula_response][:tc_kimlik_no_dogrula_result]
    expect(bool_value).to equal(false)
  end
end
