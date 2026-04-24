cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks_merge
label: kmtricks_merge
doc: "Merge partitions.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: clear
    type:
      - 'null'
      - boolean
    doc: clear partition files.
    inputBinding:
      position: 101
      prefix: --clear
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: output compressed matrices.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: mode
    type:
      - 'null'
      - string
    doc: matrix mode <mode:format:out>, see README
    inputBinding:
      position: 101
      prefix: --mode
  - id: partition_id
    type:
      - 'null'
      - int
    doc: partition id (-1 = all partitions are processed).
    inputBinding:
      position: 101
      prefix: --partition-id
  - id: recurrence_min
    type:
      - 'null'
      - int
    doc: min recurrence to keep a k-mer/hash.
    inputBinding:
      position: 101
      prefix: --recurrence-min
  - id: run_dir
    type: Directory
    doc: kmtricks runtime directory.
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: share_min
    type:
      - 'null'
      - int
    doc: save a non-solid k-mer if it is solid in N other samples.
    inputBinding:
      position: 101
      prefix: --share-min
  - id: soft_min
    type:
      - 'null'
      - string
    doc: min abundance to keep a k-mer/hash, see README.
    inputBinding:
      position: 101
      prefix: --soft-min
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
stdout: kmtricks_merge.out
