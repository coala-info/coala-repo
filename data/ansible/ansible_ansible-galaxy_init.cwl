cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ansible-galaxy
  - init
label: ansible_ansible-galaxy_init
doc: "Create the skeleton of a new Ansible role.\n\nTool homepage: https://github.com/ansible/ansible"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: role_name
    type: string
    doc: Name of the new role
    inputBinding:
      position: 10
  - id: init_path
    type:
      - 'null'
      - string
    doc: The path in which the skeleton role will be created. The default is the current
      working directory.
    inputBinding:
      position: 1
      prefix: --init-path
  - id: offline
    type:
      - 'null'
      - boolean
    doc: Don't query the galaxy API when creating roles
    inputBinding:
      position: 1
      prefix: --offline
  - id: server
    type:
      - 'null'
      - string
    doc: The API server destination
    inputBinding:
      position: 1
      prefix: --server
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting an existing role
    inputBinding:
      position: 1
      prefix: --force
outputs:
  - id: role_dir
    type: Directory
    doc: The new role skeleton (defaults, files, handlers, meta, tasks, templates, vars)
    outputBinding:
      glob: '$(inputs.init_path ? inputs.init_path + "/" + inputs.role_name : inputs.role_name)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
