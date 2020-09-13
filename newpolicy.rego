package envoy.authz

import input.attributes.request.http as http_request

default allow = false

discovery_doc := "https://example.com/.well-known/openid-configuration/jwks"
jwks_request := http.send({"cache": true, "method": "GET", "url": ""})

token = {"valid": valid, "payload": payload} {
  [_, encoded] := split(http_request.headers.authorization, " ")
  valid := io.jwt.verify_rs256(encoded, jwks_request.raw_body)
  [_, payload, _] := io.jwt.decode(encoded)
}

allow {
  is_token_valid
}

is_token_valid {
  token.valid
  now := time.now_ns() / 1000000000
  token.payload.nbf <= now
  now < token.payload.exp
}

