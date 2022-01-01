require 'vacuum'

request = Vacuum.new(
  marketplace: APP_CONFIG['aws_locale'],
  access_key: APP_CONFIG['aws_access_key_id'],
  secret_key: APP_CONFIG['aws_secret_access_key'],
  partner_tag: 'foobar'
)

response = request.item_lookup(
  query: {
    'ItemId' => '0679753354'
  }
)
