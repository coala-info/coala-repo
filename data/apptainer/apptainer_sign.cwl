cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sign
label: apptainer_sign
doc: "Add digital signature(s) to an image. The sign command allows a user to add
  one or more digital signatures to a SIF image. By default, one digital signature
  is added for each object group in the file.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_path
    type: File
    doc: Path to the SIF image
    inputBinding:
      position: 1
  - id: group_id
    type:
      - 'null'
      - int
    doc: sign objects with the specified group ID
    inputBinding:
      position: 102
      prefix: --group-id
  - id: key
    type:
      - 'null'
      - File
    doc: path to the private key file
    inputBinding:
      position: 102
      prefix: --key
  - id: keyidx
    type:
      - 'null'
      - int
    doc: PGP private key to use (index from 'key list --secret')
    inputBinding:
      position: 102
      prefix: --keyidx
  - id: sif_id
    type:
      - 'null'
      - int
    doc: sign object with the specified ID
    inputBinding:
      position: 102
      prefix: --sif-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_sign.out
