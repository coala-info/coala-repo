cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ansible-galaxy
  - install
label: ansible_ansible-galaxy_install
doc: "Install Ansible roles from Galaxy, from SCM URLs, from local role tar files or from
  a role file.\n\nTool homepage: https://github.com/ansible/ansible"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.roles_path) { l.push({"entry": inputs.roles_path, "writable": true}); }
        if (inputs.tar_files) { l = l.concat(inputs.tar_files); }
        return l;
      }
arguments:
  - position: 1
    prefix: --roles-path
    valueFrom: '$(inputs.roles_path ? inputs.roles_path.basename : inputs.roles_path_name)'
inputs:
  - id: role_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Galaxy role names (role_name[,version]) or SCM URLs (scm+role_repo_url[,version])
    inputBinding:
      position: 10
  - id: tar_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Local role tar files (each role is named after its tar file)
    inputBinding:
      position: 11
      valueFrom: '${ return self.map(function(f) { return f.basename; }); }'
  - id: role_file
    type:
      - 'null'
      - File
    doc: A file containing a list of roles to be imported
    inputBinding:
      position: 1
      prefix: --role-file
  - id: roles_path
    type:
      - 'null'
      - Directory
    doc: Existing directory containing your roles to install into (a changed copy is returned)
  - id: roles_path_name
    type: string
    doc: Name of the new roles directory, used when roles_path is not given
    default: roles
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: Ignore errors and continue with the next specified role.
    inputBinding:
      position: 1
      prefix: --ignore-errors
  - id: no_deps
    type:
      - 'null'
      - boolean
    doc: Don't download roles listed as dependencies
    inputBinding:
      position: 1
      prefix: --no-deps
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
  - id: roles_dir
    type: Directory
    doc: Roles directory with the installed roles
    outputBinding:
      glob: '$(inputs.roles_path ? inputs.roles_path.basename : inputs.roles_path_name)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
