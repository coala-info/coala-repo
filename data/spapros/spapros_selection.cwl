cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spapros
  - selection
label: spapros_selection
doc: "Create a selection of probesets for an h5ad file.\n\nTool homepage: https://github.com/theislab/spapros"
inputs:
  - id: data
    type: File
    doc: Path to the h5ad file
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
