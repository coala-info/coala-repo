cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ansible-galaxy
  - remove
label: ansible_ansible-galaxy_remove
doc: "Remove installed Ansible roles from a roles directory.\n\nTool homepage: https://github.com/ansible/ansible"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.roles_path)
        writable: true
arguments:
  - position: 1
    prefix: --roles-path
    valueFrom: $(inputs.roles_path.basename)
inputs:
  - id: roles
    type:
      type: array
      items: string
    doc: Names of the roles to remove
    inputBinding:
      position: 10
  - id: roles_path
    type: Directory
    doc: The directory containing your roles (a changed copy is returned)
outputs:
  - id: roles_dir
    type: Directory
    doc: Roles directory without the removed roles
    outputBinding:
      glob: $(inputs.roles_path.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
