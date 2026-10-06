cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - key
  - import
label: apptainer_key_import
doc: "The 'key import' command allows you to add a key to your local or global keyring
  from a specific file.\n\nTool homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.keysdir ? [{"entry": inputs.keysdir, "writable": true}] : []; }'
arguments:
  - position: 1
    prefix: --keysdir
    valueFrom: '$(inputs.keysdir ? inputs.keysdir.basename : inputs.keysdir_name)'
inputs:
  - id: input_key
    type: File
    doc: Key file to import (ASCII armored or binary)
    inputBinding:
      position: 10
  - id: keysdir
    type:
      - 'null'
      - Directory
    doc: existing local keyring dir to import into (a changed copy is returned)
  - id: keysdir_name
    type: string
    doc: name of the new keyring dir, used when keysdir is not given
    default: keys
  - id: global
    type:
      - 'null'
      - boolean
    doc: manage global public keys (import/pull/remove are restricted to root user or
      unprivileged installation only)
    inputBinding:
      position: 1
      prefix: --global
  - id: new_password
    type:
      - 'null'
      - boolean
    doc: set a new password to the private key (asks for the password on the terminal)
    inputBinding:
      position: 1
      prefix: --new-password
outputs:
  - id: keyring
    type: Directory
    doc: Keyring folder with the imported key
    outputBinding:
      glob: '$(inputs.keysdir ? inputs.keysdir.basename : inputs.keysdir_name)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
