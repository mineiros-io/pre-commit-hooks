[<img src="https://raw.githubusercontent.com/mineiros-io/brand/master/mineiros-primary-logo.svg" width="400"/>](https://www.mineiros.io/?ref=pre-commit-hooks)

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/pre-commit-hooks.svg?label=latest&sort=semver)](https://github.com/mineiros-io/pre-commit-hooks/releases)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623CE4.svg)](https://github.com/hashicorp/terraform/releases)
[<img src="https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack">](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

# pre-commit-hooks

This repository is a collection of Git hooks to be used with the
[pre-commit](https://pre-commit.com/) framework.

- [Available Hooks](#available-hooks)
  - [Terraform](#terraform)
  - [Go](#go)
  - [GNU Make](#gnu-make)
  - [Markdown](#markdown)
  - [Bash](#bash)
- [Installation & Dependencies](#installation--dependencies)
- [Usage](#usage)
  - [Run](#run)
    - [Example: Run All Hooks](#example-run-all-hooks)
    - [Example: Run A Specific Hook](#example-run-a-specific-hook)
  - [Pre-Commit and Continuous Integration](#pre-commit-and-continuous-integration)
  - [Add Custom Hooks](#add-custom-hooks)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Available Hooks

Currently, the following hooks are supported:

### Terraform

- [terraform-fmt](https://www.terraform.io/docs/commands/fmt.html): The terraform fmt command is used to rewrite
  Terraform configuration `*.tf` files to a canonical format and style.
- [terraform-validate](https://www.terraform.io/docs/commands/validate.html): The terraform validate command validates
  all Terraform configuration `*.tf` files, referring only to the configuration and not accessing any remote services
  such as remote state, provider APIs, etc.
- [tflint](https://github.com/terraform-linters/tflint): TFLint is a Terraform linter focused on possible errors, best
  practices, etc. (Terraform >= 0.12). Applied to all Terraform configuration `*.tf` files.

### Go

- [gofmt](https://golang.org/cmd/gofmt/): Go fmt is a tool that automatically formats Go `*.go` files to canonical
  format and style.
- [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports): The goimports command updates import lines in Go
  `*.go` files, adding missing ones and removing unreferenced ones.
- [golint](https://github.com/golang/lint): Golint is a linter that formats your Go `*.go` files.
- [golangci-lint](https://github.com/golangci/golangci-lint): GolangCI-Lint is a linters aggregator.
  It's fast: on average 5 times faster than gometalinter. It's easy to integrate and use, has nice output and has a
  minimum number of false positives.

### GNU Make

- [phony-targets](https://github.com/mineiros-io/pre-commit-hooks/blob/master/pre_commit_hooks/make/phony-targets.sh):
  This hook validates if targets that are marked as `PHONY` actually exist.

### Markdown

- [markdown-link-check](https://github.com/tcort/markdown-link-check): Checks that all of the hyperlinks in a markdown
  text to determine if they are alive or dead.

### Bash

- [shellcheck](https://github.com/koalaman/shellcheck): ShellCheck is a GPLv3 tool that gives warnings and suggestions
  for bash/sh shell scripts.

## Installation & Dependencies

1. Install [pre-commit](https://pre-commit.com/). E.g. `brew install pre-commit`
1. Install [Terraform](https://www.terraform.io/), [TFLint](https://github.com/terraform-linters/tflint),
   [Go](https://golang.org/), [markdown-link-check](https://github.com/tcort/markdown-link-check),
   [shellcheck](https://github.com/koalaman/shellcheck). E.g

   ```shell script
     brew install terraform \
         tflint \
         go \
         golangci/tap/golangci-lint \
         shellcheck && \
         npm install -g markdown-link-check
   ```

## Usage

Create a `.pre-commit-config.yaml` inside your repositories and add the desired list of hooks.
Please see the [documentation](https://pre-commit.com/#usage) for further information.

```yaml
repos:
  - repo: https://github.com/mineiros-io/pre-commit-hooks
    rev: <VERSION> # Check for the latest version: https://github.com/mineiros-io/pre-commit-hooks/releases
    hooks:
      - id: terraform-fmt
      - id: terraform-validate
      - id: tflint
      - id: gofmt
      - id: goimports
      - id: golint
      - id: golangci-lint
      - id: phony-targets
      - id: markdown-link-check
      - id: shellcheck
```

Once you created the configuration file inside your repository, you must run `pre-commit install` to activate the hooks.
That's it, pre-commit will now listen for changes in your files and run the checks accordingly.

### Run

It's usually a good idea to run the hooks against all of the files when adding new hooks (usually pre-commit will only
run on the changed files during git hooks).

#### Example: Run All Hooks

```shell script
pre-commit run --all-files
```

#### Example: Run A Specific Hook

```shell script
pre-commit run terraform-validate --all-files
```

### Pre-Commit and Continuous Integration

It's recommended to run pre-commit as part of CI pipeline/build as there will be always that one rebel in the team
who won't run them locally. On CI, replace `pre-commit install` by `pre-commit run -a`. We don't need to install it on
CI as it'll be a one-shot operation. run -a will run the hooks over all files (taking into account excludes if
configured).

### Add Custom Hooks

All `*.sh` files inside pre_commit_hooks need to be flagged as executable. Otherwise the pre-commit hooks won't be
executable by default. You apply the flag to all `*.sh` files with the following command:

```bash
find pre_commit_hooks/ -type f -iname "*.sh" -exec chmod +x {} \;
```

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is
  increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is
  increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service](https://mineiros.io/?ref=pre-commit-hooks) company based in Berlin, Germany. We offer commercial support
for all of our projects and encourage you to reach out if you have any questions or need help.
Feel free to send us an email at [hello@mineiros.io](mailto:hello@mineiros.io).

We can also help you with:

- Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases, logging and monitoring, CI, etc.
- Consulting & training on AWS, Terraform and DevOps

## Reporting Issues

We use GitHub [Issues](https://github.com/mineiros-io/pre-commit-hooks/issues)
to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests](https://github.com/mineiros-io/pre-commit-hooks/pulls). If you'd like more information, please
see our [Contribution Guidelines](https://github.com/mineiros-io/pre-commit-hooks/blob/master/CONTRIBUTING.md).

## Makefile Targets

This repository comes with a handy
[Makefile](https://github.com/mineiros-io/pre-commit-hooks/blob/master/Makefile).
Run `make help` to see details on each available target.

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/pre-commit-hooks/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros GmbH
