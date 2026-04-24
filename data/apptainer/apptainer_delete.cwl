cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - delete
label: apptainer_delete
doc: "Deletes requested image from the library\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: image_ref
    type: string
    doc: The reference of the image to delete (e.g., library://username/project/image:1.0)
    inputBinding:
      position: 1
  - id: arch
    type:
      - 'null'
      - string
    doc: specify requested image arch
    inputBinding:
      position: 102
      prefix: --arch
  - id: force
    type:
      - 'null'
      - boolean
    doc: delete image without confirmation
    inputBinding:
      position: 102
      prefix: --force
  - id: library
    type:
      - 'null'
      - string
    doc: delete images from the provided library
    inputBinding:
      position: 102
      prefix: --library
  - id: no_https
    type:
      - 'null'
      - boolean
    doc: use http instead of https for docker:// oras:// and library://<hostname>/...
      URIs
    inputBinding:
      position: 102
      prefix: --no-https
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_delete.out
