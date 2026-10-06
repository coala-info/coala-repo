cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ansible-galaxy
  - info
label: ansible_ansible-galaxy_info
doc: "Show details about an installed Ansible role and about the role on the Galaxy server.\n\nTool homepage: https://github.com/ansible/ansible"
inputs:
  - id: role_name
    type: string
    doc: Role name, optionally with a version (role_name[,version])
    inputBinding:
      position: 10
  - id: roles_path
    type:
      - 'null'
      - Directory
    doc: The path to the directory containing your roles. The default is the roles_path
      configured in your ansible.cfg file (/etc/ansible/roles if not configured)
    inputBinding:
      position: 1
      prefix: --roles-path
  - id: server
    type:
      - 'null'
      - string
    doc: The API server destination
    inputBinding:
      position: 1
      prefix: --server
outputs:
  - id: stdout
    type: stdout
    doc: Role details
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
stdout: ansible_ansible-galaxy_info.out
