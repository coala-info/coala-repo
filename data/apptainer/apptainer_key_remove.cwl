cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - key
  - remove
label: apptainer_key_remove
doc: "The 'key remove' command will remove a local public key from the local or the
  global keyring.\n\nTool homepage: https://github.com/apptainer/apptainer"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.keysdir)
        writable: true
arguments:
  - position: 1
    prefix: --keysdir
    valueFrom: $(inputs.keysdir.basename)
inputs:
  - id: fingerprint
    type: string
    doc: Fingerprint of the public key to remove
    inputBinding:
      position: 10
  - id: keysdir
    type: Directory
    doc: local keyring dir to remove the key from (a changed copy is returned)
  - id: global
    type:
      - 'null'
      - boolean
    doc: manage global public keys (import/pull/remove are restricted to root user or
      unprivileged installation only)
    inputBinding:
      position: 1
      prefix: --global
  - id: both
    type:
      - 'null'
      - boolean
    doc: remove both public and private keys
    inputBinding:
      position: 1
      prefix: --both
  - id: public
    type:
      - 'null'
      - boolean
    doc: remove public keys only
    inputBinding:
      position: 1
      prefix: --public
  - id: secret
    type:
      - 'null'
      - boolean
    doc: remove secret keys only
    inputBinding:
      position: 1
      prefix: --secret
outputs:
  - id: keyring
    type: Directory
    doc: Keyring folder without the removed key
    outputBinding:
      glob: $(inputs.keysdir.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
