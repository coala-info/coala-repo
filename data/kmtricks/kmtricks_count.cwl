cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks count
label: kmtricks_count
doc: "Count k-mers/hashes in partitions.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: clear
    type:
      - 'null'
      - boolean
    doc: clear super-k-mer files.
    inputBinding:
      position: 101
      prefix: --clear
  - id: cpr
    type:
      - 'null'
      - boolean
    doc: output compressed partitions.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: hard_min
    type:
      - 'null'
      - int
    doc: min abundance to keep a k-mer/hash.
    default: 2
    inputBinding:
      position: 101
      prefix: --hard-min
  - id: hist
    type:
      - 'null'
      - boolean
    doc: compute k-mer histograms.
    inputBinding:
      position: 101
      prefix: --hist
  - id: id
    type: string
    doc: sample ID, as define in kmtricks fof.
    inputBinding:
      position: 101
      prefix: --id
  - id: mode
    type: string
    doc: count k-mers or hashes. [kmer|hash|vector|kff]
    inputBinding:
      position: 101
      prefix: --mode
  - id: partition_id
    type:
      - 'null'
      - int
    doc: 'partition id (default: all partitions are processed.'
    default: -1
    inputBinding:
      position: 101
      prefix: --partition-id
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
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: verbosity level [debug|info|warning|error].
    default: info
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
stdout: kmtricks_count.out
