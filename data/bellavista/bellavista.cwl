cwlVersion: v1.2
class: CommandLineTool
baseCommand: bellavista
label: bellavista
doc: "Process input file for Bellavista.\n\nTool homepage: https://github.com/pkosurilab/BellaVista"
inputs:
  - id: positional_input_file
    type:
      - 'null'
      - File
    doc: Path to the input JSON file
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to the input JSON file
    inputBinding:
      position: 102
      prefix: --input-file
  - id: xenium_sample
    type:
      - 'null'
      - string
    doc: Path to the input JSON file
    inputBinding:
      position: 102
      prefix: --xenium-sample
  - id: xenium_sample_lite
    type:
      - 'null'
      - string
    doc: Path to the input JSON file
    inputBinding:
      position: 102
      prefix: --xenium-sample-lite
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellavista:0.0.2--pyhdfd78af_1
stdout: bellavista.out
