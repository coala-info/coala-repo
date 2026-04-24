cwlVersion: v1.2
class: CommandLineTool
baseCommand: ansible
label: ansible
doc: "Ansible is an IT automation tool that can configure systems, deploy software,
  and orchestrate more advanced IT tasks such as continuous deployments or zero downtime
  rolling updates.\n\nTool homepage: https://github.com/ansible/ansible"
inputs:
  - id: host_pattern
    type: string
    doc: Host pattern to target
    inputBinding:
      position: 1
  - id: ask_become_pass
    type:
      - 'null'
      - boolean
    doc: ask for privilege escalation password
    inputBinding:
      position: 102
      prefix: --ask-become-pass
  - id: ask_pass
    type:
      - 'null'
      - boolean
    doc: ask for SSH password
    inputBinding:
      position: 102
      prefix: --ask-pass
  - id: ask_su_pass
    type:
      - 'null'
      - boolean
    doc: ask for su password (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --ask-su-pass
  - id: ask_sudo_pass
    type:
      - 'null'
      - boolean
    doc: ask for sudo password (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --ask-sudo-pass
  - id: ask_vault_pass
    type:
      - 'null'
      - boolean
    doc: ask for vault password
    inputBinding:
      position: 102
      prefix: --ask-vault-pass
  - id: background
    type:
      - 'null'
      - int
    doc: run asynchronously, failing after X seconds
    inputBinding:
      position: 102
      prefix: --background
  - id: become
    type:
      - 'null'
      - boolean
    doc: run operations with become (nopasswd implied)
    inputBinding:
      position: 102
      prefix: --become
  - id: become_method
    type:
      - 'null'
      - string
    doc: privilege escalation method to use
    inputBinding:
      position: 102
      prefix: --become-method
  - id: become_user
    type:
      - 'null'
      - string
    doc: run operations as this user
    inputBinding:
      position: 102
      prefix: --become-user
  - id: check
    type:
      - 'null'
      - boolean
    doc: don't make any changes; instead, try to predict some of the changes that
      may occur
    inputBinding:
      position: 102
      prefix: --check
  - id: connection
    type:
      - 'null'
      - string
    doc: connection type to use
    inputBinding:
      position: 102
      prefix: --connection
  - id: extra_vars
    type:
      - 'null'
      - string
    doc: set additional variables as key=value or YAML/JSON
    inputBinding:
      position: 102
      prefix: --extra-vars
  - id: forks
    type:
      - 'null'
      - int
    doc: specify number of parallel processes to use
    inputBinding:
      position: 102
      prefix: --forks
  - id: inventory_file
    type:
      - 'null'
      - File
    doc: specify inventory host file
    inputBinding:
      position: 102
      prefix: --inventory-file
  - id: limit
    type:
      - 'null'
      - string
    doc: further limit selected hosts to an additional pattern
    inputBinding:
      position: 102
      prefix: --limit
  - id: list_hosts
    type:
      - 'null'
      - boolean
    doc: outputs a list of matching hosts; does not execute anything else
    inputBinding:
      position: 102
      prefix: --list-hosts
  - id: module_args
    type:
      - 'null'
      - string
    doc: module arguments
    inputBinding:
      position: 102
      prefix: --args
  - id: module_name
    type:
      - 'null'
      - string
    doc: module name to execute
    inputBinding:
      position: 102
      prefix: --module-name
  - id: module_path
    type:
      - 'null'
      - Directory
    doc: specify path(s) to module library
    inputBinding:
      position: 102
      prefix: --module-path
  - id: one_line
    type:
      - 'null'
      - boolean
    doc: condense output
    inputBinding:
      position: 102
      prefix: --one-line
  - id: poll
    type:
      - 'null'
      - int
    doc: set the poll interval if using -B
    inputBinding:
      position: 102
      prefix: --poll
  - id: private_key
    type:
      - 'null'
      - File
    doc: use this file to authenticate the connection
    inputBinding:
      position: 102
      prefix: --private-key
  - id: su
    type:
      - 'null'
      - boolean
    doc: run operations with su (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --su
  - id: su_user
    type:
      - 'null'
      - string
    doc: run operations with su as this user (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --su-user
  - id: sudo
    type:
      - 'null'
      - boolean
    doc: run operations with sudo (nopasswd) (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --sudo
  - id: sudo_user
    type:
      - 'null'
      - string
    doc: desired sudo user (deprecated, use become)
    inputBinding:
      position: 102
      prefix: --sudo-user
  - id: timeout
    type:
      - 'null'
      - int
    doc: override the SSH timeout in seconds
    inputBinding:
      position: 102
      prefix: --timeout
  - id: user
    type:
      - 'null'
      - string
    doc: connect as this user
    inputBinding:
      position: 102
      prefix: --user
  - id: vault_password_file
    type:
      - 'null'
      - File
    doc: vault password file
    inputBinding:
      position: 102
      prefix: --vault-password-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (-vvv for more, -vvvv to enable connection debugging)
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: tree
    type:
      - 'null'
      - Directory
    doc: log output to this directory
    outputBinding:
      glob: $(inputs.tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
