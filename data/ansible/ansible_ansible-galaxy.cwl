cwlVersion: v1.2
class: CommandLineTool
baseCommand: ansible-galaxy
label: ansible_ansible-galaxy
doc: "Manage Ansible roles and collections.\n\nTool homepage: https://github.com/ansible/ansible"
inputs:
  - id: command
    type: string
    doc: 'The action to perform: init, info, install, list, or remove'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific options and arguments
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
stdout: ansible_ansible-galaxy.out
