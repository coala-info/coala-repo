cwlVersion: v1.2
class: CommandLineTool
baseCommand: parebrick-charts
label: parebrick_charts
doc: "Building charts for pan-genome analysis based on synteny blocks.\n\nTool homepage:
  https://github.com/ctlab/parallel-rearrangements"
inputs:
  - id: infercars_file
    type: File
    doc: Path to file in infercars format, can be found in main script output
    inputBinding:
      position: 101
      prefix: --infercars_file
  - id: output_path
    type:
      - 'null'
      - string
    doc: Path to output folder.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to output folder.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parebrick:0.5.7--pyhdfd78af_0
