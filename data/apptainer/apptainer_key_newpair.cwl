cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - key
  - newpair
label: apptainer_key_newpair
doc: "The 'key newpair' command allows you to create a new key or public/private keys
  to be stored in the default user local keyring location (e.g., $HOME/.apptainer/keys).\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: keysdir
    type: string
    doc: set local keyring dir path where the new key pair is written
    default: keys
    inputBinding:
      position: 1
      prefix: --keysdir
  - id: bit_length
    type:
      - 'null'
      - int
    doc: specify key bit length (default 4096)
    inputBinding:
      position: 1
      prefix: --bit-length
  - id: comment
    type:
      - 'null'
      - string
    doc: key comment
    inputBinding:
      position: 1
      prefix: --comment
  - id: email
    type:
      - 'null'
      - string
    doc: key owner email
    inputBinding:
      position: 1
      prefix: --email
  - id: name
    type:
      - 'null'
      - string
    doc: key owner name
    inputBinding:
      position: 1
      prefix: --name
  - id: password
    type:
      - 'null'
      - string
    doc: key password
    inputBinding:
      position: 1
      prefix: --password
  - id: push
    type:
      - 'null'
      - boolean
    doc: specify to push the public key to the remote keystore
    inputBinding:
      position: 1
      prefix: --push
outputs:
  - id: keyring
    type: Directory
    doc: Keyring folder with pgp-public and pgp-secret
    outputBinding:
      glob: $(inputs.keysdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
