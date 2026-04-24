cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - sortBED
label: astalavista_sortbed
doc: "Sort a BED file. If no output file is specified, result is printed to standard
  out.\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: input_file
    type: File
    doc: The BED file to be sorted.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 102
      prefix: --force
  - id: log_level
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 102
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file where the sorted result is written. If not specified, result
      is printed to standard out.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
