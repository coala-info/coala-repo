cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - key
label: apptainer_key
doc: "Manage your trusted, public and private keys in your local or in the global
  keyring (local keyring: '~/.apptainer/keys' if 'APPTAINER_KEYSDIR' is not set, global
  keyring: '/usr/local/etc/apptainer/global-pgp-public')\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute: export, import, list, newpair, pull, push, remove,
      or search'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_key.out
