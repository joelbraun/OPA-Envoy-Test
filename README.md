# Overview

Uses OPA's envoy proxy extensions to provide authorization decisions on calls. Based on [this OPA tutorial](https://www.openpolicyagent.org/docs/latest/envoy-authorization/) this tests the following additional features:
- Pulling a JWKS discovery document to validate JWTs against public keys inside OPA
- Validating allowed paths on an API based on user metadata
- Pulling associated roles from a roles/permissions service to use in validation inside OPA

To run this app, setup `minikube` and then run `setup_cluster.sh`.

# Things Inside

- **Policy Data API:** Hosts a single endpoint which delivers the associated roles that a user has at a specific tenant. Queried by the OPA sidecar.

- **Sample API:** A .NET Sample API with the envoy sidecar running that uses OPA to validate whether certain paths are valid for the user before the application itself is hit. Has a single endpoint with `tenant` in the path that is validated against the allowed tenants for the user.

- **newpolicy.rego:** A rego policy which validates JWTs, checks the path for a tenant, pulls permissions, and validates the user has access to the thenant.
