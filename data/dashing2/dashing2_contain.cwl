cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing2 contain
label: dashing2_contain
doc: "This application is inspired by mash screen.\n\nTool homepage: https://github.com/dnbaker/dashing2"
inputs:
  - id: database_kmers
    type: File
    doc: database.kmers
    inputBinding:
      position: 1
  - id: input_fq
    type:
      type: array
      items: File
    doc: input.fq
    inputBinding:
      position: 2
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Emit binary output instead of human-readable.
    inputBinding:
      position: 103
      prefix: -b
  - id: output
    type:
      - 'null'
      - string
    doc: Set output
    inputBinding:
      position: 103
      prefix: -o
  - id: read_input_paths_from_file
    type:
      - 'null'
      - File
    doc: read input paths from file at <arg>
    inputBinding:
      position: 103
      prefix: -F
  - id: threads
    type:
      - 'null'
      - int
    doc: set number of threads.
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing2:2.1.20--he9e5f93_0
stdout: dashing2_contain.out
