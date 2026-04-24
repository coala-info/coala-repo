cwlVersion: v1.2
class: CommandLineTool
baseCommand: ansible-pull
label: ansible_ansible-pull
doc: "Pulls playbooks from a VCS repo and executes them for the local host.\n\nTool
  homepage: https://github.com/ansible/ansible"
inputs:
  - id: playbook
    type:
      - 'null'
      - File
    doc: The playbook file to run
    inputBinding:
      position: 1
  - id: accept_host_key
    type:
      - 'null'
      - boolean
    doc: adds the hostkey for the repo url if not already added
    inputBinding:
      position: 102
      prefix: --accept-host-key
  - id: ask_sudo_pass
    type:
      - 'null'
      - boolean
    doc: ask for sudo password
    inputBinding:
      position: 102
      prefix: --ask-sudo-pass
  - id: checkout
    type:
      - 'null'
      - string
    doc: branch/tag/commit to checkout. Defaults to behavior of repository module.
    inputBinding:
      position: 102
      prefix: --checkout
  - id: directory
    type:
      - 'null'
      - Directory
    doc: directory to checkout repository to
    inputBinding:
      position: 102
      prefix: --directory
  - id: extra_vars
    type:
      - 'null'
      - string
    doc: set additional variables as key=value or YAML/JSON
    inputBinding:
      position: 102
      prefix: --extra-vars
  - id: force
    type:
      - 'null'
      - boolean
    doc: run the playbook even if the repository could not be updated
    inputBinding:
      position: 102
      prefix: --force
  - id: git_force
    type:
      - 'null'
      - boolean
    doc: modified files in the working git repository will be discarded
    inputBinding:
      position: 102
      prefix: --git-force
  - id: inventory_file
    type:
      - 'null'
      - File
    doc: location of the inventory host file
    inputBinding:
      position: 102
      prefix: --inventory-file
  - id: key_file
    type:
      - 'null'
      - File
    doc: Pass '-i <key_file>' to the SSH arguments used by git.
    inputBinding:
      position: 102
      prefix: --key-file
  - id: module_name
    type:
      - 'null'
      - string
    doc: Module name used to check out repository. Default is git.
    inputBinding:
      position: 102
      prefix: --module-name
  - id: only_if_changed
    type:
      - 'null'
      - boolean
    doc: only run the playbook if the repository has been updated
    inputBinding:
      position: 102
      prefix: --only-if-changed
  - id: purge
    type:
      - 'null'
      - boolean
    doc: purge checkout after playbook run
    inputBinding:
      position: 102
      prefix: --purge
  - id: sleep
    type:
      - 'null'
      - int
    doc: sleep for random interval (between 0 and n number of seconds) before starting.
      this is a useful way to disperse git requests
    inputBinding:
      position: 102
      prefix: --sleep
  - id: tags
    type:
      - 'null'
      - string
    doc: only run plays and tasks tagged with these values
    inputBinding:
      position: 102
      prefix: --tags
  - id: track_submodules
    type:
      - 'null'
      - boolean
    doc: submodules will track the latest commit on their master branch (or other
      branch specified in .gitmodules). This is equivalent to specifying the --remote
      flag to git submodule update
    inputBinding:
      position: 102
      prefix: --track-submodules
  - id: url
    type:
      - 'null'
      - string
    doc: URL of the playbook repository
    inputBinding:
      position: 102
      prefix: --url
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
    doc: Pass -vvvv to ansible-playbook
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ansible:1.9.4--py27_0
stdout: ansible_ansible-pull.out
