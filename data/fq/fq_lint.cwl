cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fq
  - lint
label: fq_lint
doc: "Validates a FASTQ file pair\n\nTool homepage: https://github.com/stjude-rust-labs/fq"
inputs:
  - id: r1_src
    type: File
    doc: Read 1 source. Accepts both raw and gzipped FASTQ inputs
    inputBinding:
      position: 1
  - id: r2_src
    type:
      - 'null'
      - File
    doc: Read 2 source. Accepts both raw and gzipped FASTQ inputs
    inputBinding:
      position: 2
  - id: disable_validator
    type:
      - 'null'
      - type: array
        items: string
    doc: Disable validators by code. Use multiple times to disable more than one
    inputBinding:
      position: 103
      prefix: --disable-validator
  - id: lint_mode
    type:
      - 'null'
      - string
    doc: Panic on first error or log all errors
    inputBinding:
      position: 103
      prefix: --lint-mode
  - id: paired_read_validation_level
    type:
      - 'null'
      - string
    doc: Only use paired read validators up to a given level
    inputBinding:
      position: 103
      prefix: --paired-read-validation-level
  - id: record_definition_separator
    type:
      - 'null'
      - string
    doc: "Define a record definition separator.\n          \n          This is used
      to strip the definition from a record name."
    inputBinding:
      position: 103
      prefix: --record-definition-separator
  - id: single_read_validation_level
    type:
      - 'null'
      - string
    doc: Only use single read validators up to a given level
    inputBinding:
      position: 103
      prefix: --single-read-validation-level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
stdout: fq_lint.out
