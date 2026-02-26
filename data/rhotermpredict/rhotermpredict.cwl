cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhotermpredict
label: rhotermpredict
doc: "RhoTermPredict (Barrick Lab Fork)\n\nTool homepage: https://github.com/barricklab/RhoTermPredict"
inputs:
  - id: input
    type:
      - 'null'
      - string
    doc: Input filename (FASTA) or DNA/RNA sequence.
    inputBinding:
      position: 101
      prefix: --input
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly (default is False)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: type
    type:
      - 'null'
      - string
    doc: Input type (overrides autodetection)
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file path. If not provided, results will output\nto the console"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhotermpredict:3.4--pyh7e72e81_0
