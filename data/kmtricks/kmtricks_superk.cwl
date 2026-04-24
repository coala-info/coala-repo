cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmtricks
  - superk
label: kmtricks_superk
doc: "Compute super-k-mers.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: output compressed super-k-mers.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: id
    type: string
    doc: sample ID, as define in the input fof.
    inputBinding:
      position: 101
      prefix: --id
  - id: restrict_to_list
    type:
      - 'null'
      - string
    doc: process only some partitions, comma separated.
    inputBinding:
      position: 101
      prefix: --restrict-to-list
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
stdout: kmtricks_superk.out
