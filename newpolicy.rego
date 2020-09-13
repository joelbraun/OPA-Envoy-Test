package envoy.authz

import input.attributes.request.http as http_request
import input
default allow = false

# set your real JWKS discovery doc here to pull the public keys for token validation
discovery_doc := "https://signin.example.com/.well-known/openid-configuration/jwks"
jwks_request := http.send({"cache": true, "method": "GET", "url": discovery_doc})

# validate token signature
token = {"valid": valid, "payload": payload} {
  [_, encoded] := split(http_request.headers.authorization, " ")
  valid := io.jwt.verify_rs256(encoded, jwks_request.raw_body)
  [_, payload, _] := io.jwt.decode(encoded)
}

# signature and token lifetime validation
is_token_valid {
  token.valid
  now := time.now_ns() / 1000000000
  token.payload.nbf <= now
  now < token.payload.exp
}

# check specific http method
action_allowed {
  http_request.method == "GET"
  # check that the first two properties of the parsed path are tenant and an allowed tenant ID
  # i'm sure there's a smarter way to do this slice using pattern matching or somesuch
  slice := array.slice(input.parsed_path, 0, 2)
  lower(slice[0]) == "tenant"
  tenantId = slice[1]

  # get user's allowed roles for tenant and check that the user is an admin
  allowedTenantsResult := http.send({
    "method": "GET",
    "url": concat("",["http://example-policy-service:8081/users/", token.payload.sub, "/tenants/", tenantId, "/roles" ])
  })

  #idiomatic `contains` function
  allowedTenantsResult.body.roles[_] = "admin"
}

# final decision is the set of these two functions
allow {
  is_token_valid
  action_allowed
}
