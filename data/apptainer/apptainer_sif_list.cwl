cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
  - list
label: apptainer_sif_list
doc: "List data objects from a SIF image.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: sif_path
    type: File
    doc: SIF image to read
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_sif_list.out
