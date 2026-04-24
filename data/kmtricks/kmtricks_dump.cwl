cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks dump
label: kmtricks_dump
doc: "Dump kmtricks's files in human readable format.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: input
    type: File
    doc: path to file.
    inputBinding:
      position: 101
      prefix: --input
  - id: run_dir
    type: Directory
    doc: kmtricks runtime directory.
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
