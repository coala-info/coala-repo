---
name: ansible
description: Ansible is an agentless IT automation engine that automates cloud provisioning, configuration management, and application deployment.
homepage: https://github.com/ansible/ansible
---

# ansible

## Overview
Ansible is an agentless IT automation engine that automates cloud provisioning, configuration management, and application deployment. By leveraging SSH, it eliminates the need for remote agents, making it a lightweight solution for multi-node orchestration. This skill provides procedural guidance for the native command-line interface (CLI) tools used to manage the Ansible environment and its extensions.

## Installation and Environment
Ansible is primarily distributed via Python packaging.
- **Standard Installation**: Use `pip install ansible` for the full package or `pip install ansible-core` for a minimal installation.
- **Development Version**: To run the latest features, clone the repository and run the `devel` branch directly. This is recommended for developers contributing to the project or testing upcoming fixes.

## Command Line Toolset

### ansible-galaxy
Use this tool to manage Ansible Collections and Roles.
- **Install Collections**: `ansible-galaxy collection install <namespace.collection_name>`
- **Metadata Validation**: Ensure collection metadata and file system locations are aligned to avoid `KeyError` during installation.

### ansible-config
Use this tool to view, edit, and manage Ansible configuration.
- **Validation**: Use `ansible-config validate` to check the integrity of configuration files.
- **Inspection**: Use `ansible-config dump` to see the current active configuration and the source of each setting.

### ansible-test
The primary tool for testing Ansible modules and plugins.
- **Sanity Tests**: Run `ansible-test sanity` to ensure code adheres to project standards (e.g., codespell, pylint).
- **Integration Tests**: Run `ansible-test integration` to verify functional behavior across different platforms (e.g., Alpine, FreeBSD, BusyBox).
- **Targeting**: Use specific targets to limit test scope, such as `ansible-test integration user` to test the user management module.

### ansible-pull
A tool for pull-based deployments where the remote machine pulls configuration from a VCS (like Git) instead of being pushed to by a controller.
- **Verification**: Ensure the target file exists within the repository before execution to prevent runtime errors.

## Expert Tips and Best Practices
- **Agentless Execution**: Always ensure the SSH daemon is running on target machines; Ansible requires no other bootstrapping.
- **Interpreter Discovery**: When using `delegate_to`, be aware that interpreter discovery caching may behave differently; verify the Python path on the delegated host.
- **Module Defaults**: Use `module_defaults` to template common parameters for actions like `gather_facts`, `service`, or `package`.
- **Check Mode and Diff**: Combine `--check` and `--diff` to validate changes in a repository without applying them, which is particularly useful for the `git` module.
- **Temporary Paths**: If `make_tmp_path` errors occur, check the connection plugin's interaction with `become` plugins, especially on restricted shells like BusyBox.

## Reference documentation
- [Ansible README](./references/github_com_ansible_ansible.md)
- [Ansible Issues](./references/github_com_ansible_ansible_issues.md)
- [Ansible Commits](./references/github_com_ansible_ansible_commits_devel.md)