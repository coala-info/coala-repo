cwlVersion: v1.2
class: CommandLineTool
baseCommand: lint
label: nextflow_lint
doc: "Lint Nextflow scripts and config files\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: paths
    type:
      type: array
      items: string
    doc: List of paths to lint
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: File pattern to exclude from error checking (can be specified multiple 
      times)
      - .git
      - .lineage
      - .nf-test
      - .nextflow
      - work
    inputBinding:
      position: 102
      prefix: -exclude
  - id: format
    type:
      - 'null'
      - boolean
    doc: Format scripts and config files that have no errors
    inputBinding:
      position: 102
      prefix: -format
  - id: harshil_alignment
    type:
      - 'null'
      - boolean
    doc: Use Harshil alignment
    inputBinding:
      position: 102
      prefix: -harshil-alignment
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output mode for reporting errors: full, extended, concise, json'
    inputBinding:
      position: 102
      prefix: -output
  - id: sort_declarations
    type:
      - 'null'
      - boolean
    doc: Sort script declarations in Nextflow scripts
    inputBinding:
      position: 102
      prefix: -sort-declarations
  - id: spaces
    type:
      - 'null'
      - int
    doc: Number of spaces to indent
    inputBinding:
      position: 102
      prefix: -spaces
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Indent with tabs
    inputBinding:
      position: 102
      prefix: -tabs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_lint.out
