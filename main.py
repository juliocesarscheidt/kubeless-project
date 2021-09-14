import os
import json
import requests

def make_request(url, method = "GET"):
  response = requests.request(
    method,
    url,
    headers={},
    auth=None
  )
  return response

def entry(event, context):
  print('context', context)
  print('event', event)

  print('CI_ENV', os.environ.get('CI_ENV'))

  try:
    raw_response = make_request('https://api.coinbase.com/v2/prices/spot?currency=BRL')
    data_json = raw_response.json()
    bitcoin_amount = data_json['data']['amount']
    print('bitcoin_amount', bitcoin_amount)

    return json.dumps({'bitcoin_amount': str(bitcoin_amount)})

  except Exception as err:
    print(err)
    return json.dumps({'err': str(err)})

  # if not event['data'] or event['data'] is None:
  #   return json.dumps({})

  # data = {}
  # try:
  #   data = json.dumps(event['data'])

  # except Exception as err:
  #   print(err)
  #   return json.dumps({})
