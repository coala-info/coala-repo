cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - verify
label: apptainer_verify
doc: "The verify command allows a user to verify one or more digital signatures within
  a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_path
    type: File
    doc: Path to the SIF image
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: verify all objects
    inputBinding:
      position: 102
      prefix: --all
  - id: certificate
    type:
      - 'null'
      - File
    doc: path to the certificate
    inputBinding:
      position: 102
      prefix: --certificate
  - id: certificate_intermediates
    type:
      - 'null'
      - File
    doc: path to pool of intermediate certificates
    inputBinding:
      position: 102
      prefix: --certificate-intermediates
  - id: certificate_roots
    type:
      - 'null'
      - File
    doc: path to pool of root certificates
    inputBinding:
      position: 102
      prefix: --certificate-roots
  - id: group_id
    type:
      - 'null'
      - int
    doc: verify objects with the specified group ID
    inputBinding:
      position: 102
      prefix: --group-id
  - id: json
    type:
      - 'null'
      - boolean
    doc: output json
    inputBinding:
      position: 102
      prefix: --json
  - id: key
    type:
      - 'null'
      - File
    doc: path to the public key file
    inputBinding:
      position: 102
      prefix: --key
  - id: legacy_insecure
    type:
      - 'null'
      - boolean
    doc: enable verification of (insecure) legacy signatures
    inputBinding:
      position: 102
      prefix: --legacy-insecure
  - id: local
    type:
      - 'null'
      - boolean
    doc: only verify with local key(s) in keyring
    inputBinding:
      position: 102
      prefix: --local
  - id: ocsp_verify
    type:
      - 'null'
      - boolean
    doc: enable online revocation check for certificates
    inputBinding:
      position: 102
      prefix: --ocsp-verify
  - id: sif_id
    type:
      - 'null'
      - int
    doc: verify object with the specified ID
    inputBinding:
      position: 102
      prefix: --sif-id
  - id: url
    type:
      - 'null'
      - string
    doc: specify a URL for a key server
    inputBinding:
      position: 102
      prefix: --url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_verify.out
