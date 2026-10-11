cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, lint]
label: nextflow_lint
doc: "Lint Nextflow scripts and config files.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: paths
    type:
      type: array
      items: File
    doc: "Nextflow scripts and config files to lint (or format)."
    inputBinding:
      position: 9
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "File pattern to exclude from error checking."
    inputBinding:
      position: 1
      prefix: -exclude
  - id: format
    type:
      - 'null'
      - boolean
    doc: "Format scripts and config files that have no errors."
    inputBinding:
      position: 2
      prefix: -format
  - id: harshil_alignment
    type:
      - 'null'
      - boolean
    doc: "Use Harshil alignment."
    inputBinding:
      position: 3
      prefix: -harshil-alignment
  - id: output_mode
    type:
      - 'null'
      - string
    doc: "Output mode for reporting errors: full, extended, concise, json."
    inputBinding:
      position: 4
      prefix: -output
  - id: sort_declarations
    type:
      - 'null'
      - boolean
    doc: "Sort script declarations in Nextflow scripts."
    inputBinding:
      position: 5
      prefix: -sort-declarations
  - id: spaces
    type:
      - 'null'
      - int
    doc: "Number of spaces to indent."
    inputBinding:
      position: 6
      prefix: -spaces
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: "Indent with tabs."
    inputBinding:
      position: 7
      prefix: -tabs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.paths)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_lint.out
