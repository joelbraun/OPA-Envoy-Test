#!/bin/zsh

# gets the, uh, weather report(??) for a customer at a tenant if you're properly authorized
# i dunno, based on .net sample app
curl -i -H "Authorization: Bearer "$JOEL_TOKEN"" http://$SERVICE_URL/tenant/1/customer/2/weather

# query the roles associated with your user
curl -i http://$POLICY_SERVICE_URL/users/5d5f045d731061000115a7a8/tenants/1/roles