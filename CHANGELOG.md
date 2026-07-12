# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](unreleased)

IMPROVEMENTS:

- align the `Makefile` with the module template conventions: a single `dev` target (`make dev`, *Run local dev env*) and a find-based `clean`, replacing `docker`/`docker-run`/`clean-docker`/`clean-terraform`
- example: wire the `enabled` input so the fixture's `enabled = true` is no longer an undeclared-variable warning
- docs: add a registry-source usage snippet to the README, refresh the Makefile target list, and update CONTRIBUTING (`make docker` -> `make dev`)

## [2.0.0](https://github.com/hansohn/terraform-digitalocean-droplet/compare/1.1.1...2.0.0) (Jul 11, 2026)

BREAKING CHANGES:

- remove the CloudPosse `context.tf` / `null-label` interface and replace it with `name`, `enabled`, and `tags` inputs. Removed inputs include `namespace`, `tenant`, `environment`, `stage`, `delimiter`, `attributes`, `label_order`, `context`, and the `tags` **map** (`tags` is now a `list(string)`). Migration: set `name` to your previous id (e.g. `"<namespace>-<environment>"`) and pass `tags = [...]` explicitly for parity; the `igw`/`private` role tags are still applied automatically.
- rename `igw_volume_enabled` to `enable_igw_volume` and `private_volume_enabled` to `enable_private_volume`
- remove the unused `public_lb_droplet_ids` input
- change the default SSH key algorithm from `RSA` to `ED25519`; consumers using `generate_ssh_key` without pinning `algorithm` will have an Ed25519 key regenerated on next apply

FEATURES:

- support gateway-less mode: `enable_internet_gateway = false` now provisions private droplets in the VPC without the NAT gateway, floating IP, or public firewall (instead of erroring)

BUG FIXES:

- apply the my-IP web firewall rule with a single private droplet (`private_droplet_count > 1` -> `> 0`)
- correct the copy-pasted `public_lb_droplet_tag` description

IMPROVEMENTS:

- simplify the ssh-key key filename construction (string interpolation + shared local)
- gate the gateway cloud-init and public firewall on the internet gateway toggle

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
