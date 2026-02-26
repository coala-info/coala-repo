cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - evofr
  - prepare-data
label: evofr_prepare-data
doc: "Prepare data for evofr analysis using a configuration file and optional overrides.\n\
  \nTool homepage: https://github.com/blab/evofr"
inputs:
  - id: cases
    type:
      - 'null'
      - File
    doc: 'Optional override: input case counts TSV (optional)'
    inputBinding:
      position: 101
      prefix: --cases
  - id: config
    type: File
    doc: Path to YAML configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: seq_counts
    type:
      - 'null'
      - File
    doc: 'Optional override: input sequence counts TSV'
    inputBinding:
      position: 101
      prefix: --seq-counts
outputs:
  - id: output_seq_counts
    type:
      - 'null'
      - File
    doc: 'Optional override: output sequence counts TSV'
    outputBinding:
      glob: $(inputs.output_seq_counts)
  - id: output_cases
    type:
      - 'null'
      - File
    doc: 'Optional override: output case counts TSV (optional)'
    outputBinding:
      glob: $(inputs.output_cases)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0
