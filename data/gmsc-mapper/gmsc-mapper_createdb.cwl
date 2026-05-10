cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmsc-mapper createdb
label: gmsc-mapper_createdb
doc: "Create a database for GMSC.\n\nTool homepage: https://github.com/BigDataBiology/GMSC-mapper"
inputs:
  - id: mode
    type: string
    doc: Alignment tool (Diamond / MMseqs2)
    inputBinding:
      position: 101
      prefix: --mode
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable alignment console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: target_faa
    type: File
    doc: Path to the GMSC FASTA file.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to database output directory.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
