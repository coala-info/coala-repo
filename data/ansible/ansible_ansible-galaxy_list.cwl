cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ansible-galaxy
  - list
label: ansible_ansible-galaxy_list
doc: "List the Ansible roles installed in a roles directory.\n\nTool homepage: https://github.com/ansible/ansible"
inputs:
  - id: role_name
    type:
      - 'null'
      - string
    doc: Show only this role
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
outputs:
  - id: stdout
    type: stdout
    doc: Installed roles with their versions
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
stdout: ansible_ansible-galaxy_list.out
