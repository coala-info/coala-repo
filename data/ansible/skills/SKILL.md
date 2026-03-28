---
name: ansible
description: Ansible is an agentless IT automation engine that automates system configuration, task execution, and software deployment via SSH. Use when user asks to execute ad-hoc tasks, manage remote systems, view module documentation, or run sanity and integration tests using ansible-test.
homepage: https://github.com/ansible/ansible
---

# ansible

## Overview
Ansible is an agentless IT automation engine that leverages SSH to manage remote systems without requiring custom agents or additional open ports. It is designed for simplicity, security, and auditability. This skill provides guidance on using the Ansible command-line interface for ad-hoc task execution, system configuration, and the specialized `ansible-test` framework used for maintaining and extending the Ansible ecosystem.

## Command Line Best Practices

### Ad-Hoc Task Execution
Use the `ansible` command for quick, one-off tasks across your inventory.
- **Pattern**: `ansible <host-pattern> -m <module_name> -a "<module_arguments>"`
- **Check Mode**: Append `-C` or `--check` to predict changes without applying them.
- **Parallelism**: Use `-f <number>` to define the number of parallel processes (forks).
- **Privilege Escalation**: Use `-b` or `--become` to run operations with root or another user's permissions.

### Documentation and Discovery
- **List Modules**: `ansible-doc -l` to see all available modules.
- **Module Reference**: `ansible-doc <module_name>` to view parameters, returns, and examples for a specific tool.
- **Configuration**: `ansible-config dump` to see the current active configuration and where settings are derived from.

### Development and Testing (`ansible-test`)
When developing modules or plugins, use the `ansible-test` utility to ensure code quality and compatibility.

#### Sanity Testing
Sanity tests are static analysis tools (pylint, mypy, pep8) that ensure code adheres to project standards.
- **Run all sanity tests**: `ansible-test sanity -v --docker default`
- **Run specific test**: `ansible-test sanity -v --docker default --test <test_name>`
- **Targeted file**: `ansible-test sanity -v --docker default <path/to/file.py>`

#### Unit and Integration Testing
- **Unit Tests**: `ansible-test units -v --docker default` (runs pytest-style functional tests).
- **Integration Tests**: `ansible-test integration -v --docker <distro_container> <target_name>`.
- **Container Selection**: Use `--docker default` for sanity/unit tests. For integration tests, use specific distribution containers (e.g., `ubuntu2404`) found in the project's completion data.

## Expert Tips
- **Agentless Advantage**: Since Ansible is agentless, ensure the control node has SSH access and the managed nodes have Python installed.
- **Testing Isolation**: Always prefer the `--docker` or `--podman` flags with `ansible-test` to ensure a clean, reproducible environment that is isolated from your host's Python configuration.
- **Licensing Compliance**: When contributing to `ansible-core`, ensure code is GPLv3 compatible. Code in `module_utils` typically defaults to the BSD-2-Clause license.
- **Editable Installs**: For development, use `pip install -e .` from the repository root to test changes in real-time.



## Subcommands

| Command | Description |
|---------|-------------|
| ansible | Ansible is an IT automation tool that can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates. |
| ansible-galaxy | Manage Ansible roles and collections. |
| ansible-pull | Pulls playbooks from a VCS repo and executes them for the local host. |

## Reference documentation
- [Ansible Agents Guide](./references/github_com_ansible_ansible_blob_devel_AGENTS.md)
- [Ansible Project README](./references/github_com_ansible_ansible_blob_devel_README.md)