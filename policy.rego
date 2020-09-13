package envoy.authz

import input.attributes.request.http as http_request

default allow = false

jwks_request := http.send({"cache": true, "method": "GET", "url": "https://signin.mindbodyonline.com/.well-known/openid-configuration/jwks"})

token = {"valid": valid, "payload": payload} {
    [_, encoded] := split("Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjlERkRDNzQwMUU5NTk2RTAxNTQxRkMyQTM1QUIzRkQ4NjhGRUIwMDYiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJuZjNIUUI2Vmx1QVZRZndxTmFzXzJHai1zQVkifQ.eyJuYmYiOjE1OTk5NzAxNzUsImV4cCI6MTU5OTk3Mzc3NSwiaXNzIjoiaHR0cHM6Ly9zaWduaW4ubWluZGJvZHlvbmxpbmUuY29tIiwiYXVkIjpbImh0dHBzOi8vc2lnbmluLm1pbmRib2R5b25saW5lLmNvbS9yZXNvdXJjZXMiLCJNaW5kYm9keS5JZGVudGl0eS5Vc2VyR2F0ZXdheSIsIklkZW50aXR5LkxlZ2FjeS5HYXRld2F5Il0sImNsaWVudF9pZCI6Ik1pbmRib2R5LklkZW50aXR5LlVzZXJzLlVJIiwic3ViIjoiNWQ1ZjA0NWQ3MzEwNjEwMDAxMTVhN2E4IiwiYXV0aF90aW1lIjoxNTk5OTcwMTc0LCJpZHAiOiJsb2NhbCIsImVtYWlsIjoiam9lbGJyYXVuQG91dGxvb2suY29tIiwiZ2l2ZW5fbmFtZSI6IkpvZWwiLCJmYW1pbHlfbmFtZSI6IkJyYXVuIiwibGVnYWN5X2lkZW50aWZpZXIiOiJhYTU2Y2E4My05MzAwLTRkMTAtYjVhYy1iYzYyMmNlZDA4ODciLCJodHRwOi8vaWRlbnRpdHlzZXJ2ZXIudGhpbmt0ZWN0dXJlLmNvbS9jbGFpbXMvc2NvcGUiOiJ1cm46bWJvZnJhbWV3b3JrYXBpIiwibmFtZWlkIjoiam9lbGJyYXVuQG91dGxvb2suY29tIiwidW5pcXVlX25hbWUiOiJqb2VsYnJhdW5Ab3V0bG9vay5jb20iLCJodHRwczovL2F1dGgubWluZGJvZHlvbmxpbmUuY29tL2NsYWltcy9tZW1iZXJzaGlwaWRlbnRpZmllciI6ImFhNTZjYTgzLTkzMDAtNGQxMC1iNWFjLWJjNjIyY2VkMDg4NyIsInJvbGUiOiJJZGVudGl0eVNlcnZlclVzZXJzIiwiaHR0cDovL2lkZW50aXR5c2VydmVyLnRoaW5rdGVjdHVyZS5jb20vY2xhaW1zL2NsaWVudCI6IklkZW50aXR5IEFjY291bnQgU1BBIiwiY2xpZW50X2h0dHBzOi8vYXV0aC5taW5kYm9keW9ubGluZS5jb20vY2xhaW1zL09BdXRoQ2xpZW50Q29uZmlndXJhdGlvbiI6IjMxODdkYWRkLWNiMGEtNDQzZi1iYTRjLTcwY2JjNjkxMDIyNiIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJlbWFpbCIsIk1pbmRib2R5LklkZW50aXR5LlVzZXJHYXRld2F5IiwiSWRlbnRpdHkuTGVnYWN5LkdhdGV3YXkiXSwiYW1yIjpbInB3ZCJdfQ.C1wwGgyniJCBce1x_4q0lRSfutQ2sx1w8c_C4e308rYMgLgc7Gr6Qd43rB5D9PmdoiJMzeprPNDrKexQTIycigyodZHb1S6xgMMTrdPbveuRUNzlJKB70uOOJvR-p0bRtSpilVD0Ns_DUanh-L2PnEEMTDf8eyHHItZZj-wIVYbH0RxU2VbMjcE2HdKfTEH5gSf4ZOR0A9a6R2RRjgzJNo-OyrdzUSWu1DhJbUZvbw5pPHtmgkXDPFcodg3GDyAJlODQqXqjzz9JtTkHFDwIvtbvUHiLy-xjSpXwEHZ50ikOEGijWeza4CuwCWbtbWD5Y2-88TunzXwqKNN24II1lkpR5zPmAAOfrJ9_6gPnT194HNei6K9aWx6Ct5W26F4kpcsZvkCfcdAG1AHcgGIlztGGcDj_k7wQiu8Z0Vg60q8MV4yI299oIHdCqGWvnbs24Mute5D2mvDpzGXE9iRl_j6ms_oR5lZoqb25Hix2htnl2pvCiQtMs753eRrAbONcKQv0_XRRthk85snDI-yA31G6jzoeTxejAE3Tza3vW-PXSeNW3rOE-v_JEqxkpvmH9q1iBm-vswKEyKB_zDlOIm9aBSvdwT1Tp045-LJWb-TenKI9HJ6JArnZcUK9jrYwcCWYJSLdw6d7FFGtjlJMUp6tj9h3j-XJQOX-2Vi5v7E", " ")
    valid := io.jwt.verify_rs256(encoded, jwks_request.raw_body)
    [_, payload, _] := io.jwt.decode(encoded)
}

allow {
    is_token_valid
    action_allowed
}

is_token_valid {
  token.valid
  now := time.now_ns() / 1000000000
  token.payload.nbf <= now
  now < token.payload.exp
}

action_allowed {
  http_request.method == "GET"
  http_request.path == [""]
  token.payload.role == "guest"
  glob.match("/people*", [], http_request.path)
}

action_allowed {
  http_request.method == "GET"
  token.payload.role == "admin"
  glob.match("/people*", [], http_request.path)
}

action_allowed {
  http_request.method == "POST"
  token.payload.role == "admin"
  glob.match("/people", [], http_request.path)
  lower(input.parsed_body.firstname) != base64url.decode(token.payload.sub)
}