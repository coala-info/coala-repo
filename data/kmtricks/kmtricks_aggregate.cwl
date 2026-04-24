cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks aggregate
label: kmtricks_aggregate
doc: "Aggregate partition files.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: count
    type:
      - 'null'
      - string
    doc: aggregate counted k-mers/hashes. [id:kmer|hash]
    inputBinding:
      position: 101
      prefix: --count
  - id: cpr_in
    type:
      - 'null'
      - boolean
    doc: compressed inputs.
    inputBinding:
      position: 101
      prefix: --cpr-in
  - id: cpr_out
    type:
      - 'null'
      - boolean
    doc: compressed output (ignored with --format text).
    inputBinding:
      position: 101
      prefix: --cpr-out
  - id: format
    type:
      - 'null'
      - string
    doc: dump in human readable format. [text|bin]
    inputBinding:
      position: 101
      prefix: --format
  - id: matrix
    type:
      - 'null'
      - string
    doc: aggregate count matrices. [kmer|hash]
    inputBinding:
      position: 101
      prefix: --matrix
  - id: no_count
    type:
      - 'null'
      - boolean
    doc: output only k-mers (ignored with --format bin).
    inputBinding:
      position: 101
      prefix: --no-count
  - id: pa_matrix
    type:
      - 'null'
      - string
    doc: aggregate presence/absence matrices. [kmer|hash]
    inputBinding:
      position: 101
      prefix: --pa-matrix
  - id: run_dir
    type: Directory
    doc: kmtricks runtime directory.
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: sorted output (A < C < T < G).
    inputBinding:
      position: 101
      prefix: --sorted
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
    doc: output path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0
