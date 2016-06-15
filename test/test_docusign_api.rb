require 'test_helper'

require 'docusign_api'

class DocusignApiTest < Minitest::Test
  def setup
    stub_docusign_login
    @api = DocusignApi.new username: 'username', password: 'password', integrator_key: '12345', login_url: 'https://demo.docusign.net/restapi/v2/login_information'
  end

  def test_get
    url = File.join(DOCUSIGN_ACCOUNT_BASE_URL, 'templates')
    @req = stub_request(:get, url).
      with(headers: DOCUSIGN_DEFAULT_HEADERS).
      to_return( status: 200, body: '{}' )

    @api.get '/templates'
    assert_requested @req
  end

  def test_post
    url = File.join(DOCUSIGN_ACCOUNT_BASE_URL, 'templates')
    @req = stub_request(:post, url).
      with(headers: DOCUSIGN_DEFAULT_HEADERS, body: '{}').
      to_return( status: 200, body: '{}' )

    @api.post '/templates', '{}'
    assert_requested @req
  end

  def test_put
    url = File.join(DOCUSIGN_ACCOUNT_BASE_URL, 'templates')
    @req = stub_request(:put, url).
    with(headers: DOCUSIGN_DEFAULT_HEADERS, body: '{}').
    to_return( status: 200, body: '{}' )

    @api.put '/templates', '{}'
    assert_requested @req
  end

  def test_delete
    url = File.join(DOCUSIGN_ACCOUNT_BASE_URL, 'templates')
    @req = stub_request(:delete, url).
      with(headers: DOCUSIGN_DEFAULT_HEADERS).
      to_return( status: 200, body: '{}' )

    @api.delete '/templates', '{}'
    assert_requested @req
  end

  def test_send_on_behalf_of
    url = File.join(DOCUSIGN_ACCOUNT_BASE_URL, 'templates')
    @req = stub_request(:get, url).
      with(headers: DOCUSIGN_DEFAULT_HEADERS).
      to_return( status: 200, body: '{}' )

    api = DocusignApi.new username: 'username',
                           password: 'password',
                           integrator_key: '12345',
                           send_on_behalf_of: 'nobody@e.e',
                           login_url: 'https://demo.docusign.net/restapi/v2/login_information'
    api.get '/templates'
    assert_requested :get, url, headers: DOCUSIGN_SEND_ON_BEHALF_OF_HEADERS
  end
end
