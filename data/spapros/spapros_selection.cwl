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
  - id: output_path
    type: string
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
