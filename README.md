<img src="https://i.imgur.com/t8IkKoZl.png" width="200"/>

[![Maintained by Mineiros.io](https://img.shields.io/badge/maintained%20by-mineiros.io-00607c.svg)](https://www.mineiros.io/ref=pre-commit-hooks)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/pre-commit-hooks.svg?label=latest&sort=semver)](https://github.com/mineiros-io/pre-commit-hooks/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# pre-commit-hooks

This repository is a collection of Git hooks to be used with the
[pre-commit]([pre-commit hooks](https://pre-commit.com/)) framework.

Currently, the following hooks are supported:

**Terraform**
- terraform-fmt: The terraform fmt command is used to rewrite Terraform configuration `*.tf` files to a canonical format and style.
- terraform-validate: The terraform validate command validates all Terraform configuration `*.tf` files, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.
- tflint: TFLint is a Terraform linter focused on possible errors, best practices, etc. (Terraform >= 0.12). Applied to all Terraform configuration `*.tf` files.

**Go**
- gofmt: go fmt is a tool that automatically formats `*.go` files to canonical format and style..
- goimports: The goimports command updates import lines in `*.go` files, adding missing ones and removing unreferenced ones.        
- golint: Golint is a linter that formats your `*.go` files.

## Installation & Dependencies
Install [pre-commit](https://pre-commit.com/). E.G. `brew install pre-commit`



## Usage
Create a `.pre-commit-config.yaml` inside your repositories and add the desired list of hooks.
Please see the [documentation](https://pre-commit.com/#usage) for further information.

``` yaml
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
```

Once you created the configuration file inside your repository, you must run `pre-commit install` to activate the hooks.
That's it, pre-commit will now listen for changes in your files and run the checks accordingly.

### Run

It's usually a good idea to run the hooks against all of the files when adding new hooks (usually pre-commit will only
run on the changed files during git hooks).

#### Example: Run All Hooks
``` shell script
pre-commit run --all-files
``` 

#### Example: Run A Specific Hook
``` shell script
pre-commit run terraform-validate --all-files
```

### Pre-Commit and Continuous Integration
Might be also worth to run pre-commit as part of CI pipeline/build as there will be always that one rebel in the team
who won't run them locally. On CI, replace `pre-commit install` by `pre-commit run -a`. We don't need to install it on
CI as it'll be a one-shot operation. run -a will run the hooks over all files (taking into account excludes if
configured).

### Add Custom Hooks

All `*.sh` files inside pre_commit_hooks need to be flagged as executable. Otherwise the pre-commit hooks won't be
executable by default. You apply the flag to all `*.sh` files with the following command:

``` bash
find pre_commit_hooks/ -type f -iname "*.sh" -exec chmod +x {} \;
```


## About Mineiros
Mineiros is a [DevOps as a Service](https://mineiros.io/) company based in Berlin, Germany. We offer commercial support
for all of our projects and encourage you to reach out if you have any questions or need help.
Feel free to send us an email at [hello@mineiros.io](mailto:hello@mineiros.io).

We can also help you with:
- Terraform Modules for all types of infrastructure such as VPC's, Docker clusters,
databases, logging and monitoring, CI, etc.
- Consulting & Training on AWS, Terraform and DevOps.

## Reporting Issues
We use GitHub [Issues](https://github.com/mineiros-io/pre-commit-hooks/issues)
to track community reported issues and missing features.

## Contributing
Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests](https://github.com/mineiros-io/pre-commit-hooks/pulls). If you’d like more information, please
see our [Contribution Guidelines](https://github.com/mineiros-io/pre-commit-hooks/blob/master/CONTRIBUTING.md).

## License
This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/pre-commit-hooks/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros
s
