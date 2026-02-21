cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbdagcon
label: pbdagcon
doc: "PBI consensus module\n\nTool homepage: https://github.com/jgurtowski/pbdagcon_python"
inputs:
  - id: input_data
    type: File
    doc: Input data (either file path or stdin)
    inputBinding:
      position: 1
  - id: align
    type:
      - 'null'
      - boolean
    doc: Align sequences before adding to consensus
    inputBinding:
      position: 102
      prefix: --align
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --ignore_rest
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage for correction
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for correction
    inputBinding:
      position: 102
      prefix: --min-length
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of consensus threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - int
    doc: Trim alignments on either size
    inputBinding:
      position: 102
      prefix: --trim
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turns on verbose logging
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbdagcon:0.1--boost1.60_0
stdout: pbdagcon.out
