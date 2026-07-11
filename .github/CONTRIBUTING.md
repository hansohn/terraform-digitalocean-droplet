# Contributing to terraform-digitalocean-droplet

Thank you for your interest in contributing to terraform-digitalocean-droplet! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [conduct@hansohn.io](mailto:conduct@hansohn.io).

## Getting Started

Before you begin contributing, please:

1. Read the [README.md](../README.md) to understand the project
2. Check existing [issues](https://github.com/hansohn/terraform-digitalocean-droplet/issues) and [pull requests](https://github.com/hansohn/terraform-digitalocean-droplet/pulls)
3. Join discussions in [GitHub Discussions](https://github.com/hansohn/terraform-digitalocean-droplet/discussions) if you have questions

## Development Setup

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- [Make](https://www.gnu.org/software/make/) installed
- [Git](https://git-scm.com/) for version control

All Terraform tooling (`terraform`, `terraform-docs`, `tflint`, `doctl`) ships in the
[`hansohn/terraform-digitalocean`](https://hub.docker.com/r/hansohn/terraform-digitalocean) image,
so you do not need to install it locally.

### Local Development

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/terraform-digitalocean-droplet.git
   cd terraform-digitalocean-droplet
   ```

2. **Start a local dev shell** (pulls the tooling image and mounts the repo):
   ```bash
   make docker
   ```

3. **Inside the container, validate the module:**
   ```bash
   terraform init --backend=false
   terraform validate
   terraform fmt --check
   tflint
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

- **Bug fixes**: Fix issues or unexpected behavior
- **Feature additions**: Add new resources, variables, or outputs
- **Documentation improvements**: Enhance or clarify documentation
- **CI/CD improvements**: Optimize workflows and automation
- **Examples**: Add or improve usage examples

### Workflow

1. Create a new branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following our [coding standards](#coding-standards)

3. Test your changes locally:
   ```bash
   make docker
   # inside the container:
   terraform fmt --check
   terraform validate
   tflint
   ```

4. Commit your changes with clear, descriptive messages:
   ```bash
   git commit -m "Add feature: description of changes"
   ```

5. Push to your fork and submit a pull request

## Coding Standards

### Terraform Best Practices

- Run `terraform fmt` before committing
- Type all variables and document every variable and output
- Pin module sources and provider versions
- Keep resources organized across `main.tf`, `variables.tf`, `outputs.tf`, and `versions.tf`
- Follow the [Terraform style conventions](https://developer.hashicorp.com/terraform/language/syntax/style)

### Makefile Conventions

- Use descriptive target names
- Add comments for complex targets
- Include help text using `## Help text` format
- Maintain consistent formatting and indentation

### GitHub Actions Workflows

- Use specific action versions (avoid `@latest` or `@master`)
- Include descriptive job and step names
- Use caching where appropriate

## Testing

### Local Testing

Before submitting a PR, ensure:

1. **Formatting is clean:**
   ```bash
   terraform fmt --check
   ```

2. **The module validates:**
   ```bash
   terraform init --backend=false
   terraform validate
   ```

3. **Linting passes:**
   ```bash
   tflint
   ```

4. **Generated docs are up to date:**
   ```bash
   terraform-docs markdown table --output-file README.md --output-mode inject .
   ```

### CI/CD Testing

All pull requests automatically run:
- Format checks and validation
- TFLint with the project ruleset
- A `terraform-docs` output check

## Pull Request Process

1. **Before submitting:**
   - Ensure your code follows the coding standards
   - Test your changes locally
   - Update documentation if needed

2. **PR Title and Description:**
   - Use clear, descriptive titles
   - Follow the PR template structure (what, why, references)
   - Link related issues using `closes #123` or `relates to #456`

3. **PR Checklist:**
   - [ ] My code follows the project's style guidelines
   - [ ] I have tested my changes locally
   - [ ] I have updated documentation if needed
   - [ ] All CI checks are passing

4. **Review Process:**
   - Maintainers will review your PR
   - Address any feedback or requested changes
   - Once approved, a maintainer will merge your PR

## Reporting Issues

### Bug Reports

Use the [Bug Report template](ISSUE_TEMPLATE/bug-report.yml) and include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Environment details (OS, Terraform version)
- Relevant logs or error messages

### Feature Requests

Use the [Feature Request template](ISSUE_TEMPLATE/feature-request.yml) and describe:
- The problem or use case
- Proposed solution
- Alternative approaches considered
- Additional context or examples

### Support Requests

Use the [Support Request template](ISSUE_TEMPLATE/support-request.yml) for:
- Questions about usage
- Help with configuration
- General inquiries

## Security

If you discover a security vulnerability, please follow our [Security Policy](SECURITY.md) and report it to [security@hansohn.io](mailto:security@hansohn.io). Do not create a public issue.

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](../LICENSE)).

## Questions?

- Open a [Discussion](https://github.com/hansohn/terraform-digitalocean-droplet/discussions)
- Check existing [Issues](https://github.com/hansohn/terraform-digitalocean-droplet/issues)
- Review the [README](../README.md)

Thank you for contributing! 🎉
