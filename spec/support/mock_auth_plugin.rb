# frozen_string_literal: true

class MockAuthPlugin
  def fetch_uid(request)
    return unless request.headers['HTTP_AUTHORIZATION'] == 'authorized_user'
    '12345'
  end
end
