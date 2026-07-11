# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](unreleased)

- no new features in development at this time

## [1.1.1](https://github.com/hansohn/terraform-digitalocean-droplet/compare/1.1.0...1.1.1) (Jul 11, 2026)

BUG FIXES:

- load balancer: guard `data.http.myip` so enabling `enable_public_lb` without a my-IP firewall flag no longer errors with index-out-of-range
- firewall: fix misspelled `destination_load_balancer_uids` lookup key in public and private outbound rules
- volume: suffix private volume names with the index when `private_droplet_count > 1` so they no longer collide on a duplicate name

IMPROVEMENTS:

- modernize CI to run inside the `hansohn/terraform-digitalocean` image and drop the terraform min/max matrix
- migrate Dependabot to Renovate; bump `actions/checkout`, `actions/setup-python`, and pin the Slack action
- add `.terraform-docs.yml` and `CONTRIBUTING.md`; restyle section header comments to match the module template

DOCUMENTATION:

- add an Architecture section with a Mermaid diagram, NAT/gateway network-flow explanation, and feature-toggle table

## [1.1.0](https://github.com/hansohn/terraform-digitalocean-droplet/compare/1.0.0...1.1.0) (Sep 16, 2023)

FEATURES:

- add public load balancer support with forwarding rules, health checks, and sticky sessions
- add load balancer firewall and associated variables and outputs
- update CI module version

## [1.0.0](https://gitlab.hrt.io/Infrastructure/terraform-aws-athena/compare/0.1.0...1.0.0) (Mar 11, 2023)

FEATURES:

- associate droplets to firewalls via tags
- extend available resource vars
- update github actions
- add make targets
- fix linting

## [0.1.0](https://gitlab.hrt.io/Infrastructure/terraform-aws-athena/compare/0.1.0...0.1.0) (Jun 22, 2020)

FEATURES:

- initial commit
