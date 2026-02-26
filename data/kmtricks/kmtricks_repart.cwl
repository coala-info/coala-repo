cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmtricks_repart
label: kmtricks_repart
doc: "Compute minimizer repartition.\n\nTool homepage: https://github.com/tlemane/kmtricks"
inputs:
  - id: bloom_size
    type:
      - 'null'
      - int
    doc: bloom filter size
    default: 10000000
    inputBinding:
      position: 101
      prefix: --bloom-size
  - id: file
    type: File
    doc: kmtricks input file, see README.md.
    inputBinding:
      position: 101
      prefix: --file
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of a k-mer.
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minimizer_size
    type:
      - 'null'
      - int
    doc: size of minimizers.
    default: 10
    inputBinding:
      position: 101
      prefix: --minimizer-size
  - id: minimizer_type
    type:
      - 'null'
      - int
    doc: minimizer type (0=lexi, 1=freq).
    default: 0
    inputBinding:
      position: 101
      prefix: --minimizer-type
  - id: nb_partitions
    type:
      - 'null'
      - int
    doc: number of partitions (0=auto).
    default: 0
    inputBinding:
      position: 101
      prefix: --nb-partitions
  - id: repartition_type
    type:
      - 'null'
      - int
    doc: minimizer repartition (0=unordered, 1=ordered).
    default: 0
    inputBinding:
      position: 101
      prefix: --repartition-type
  - id: run_dir
    type:
      - 'null'
      - Directory
    doc: kmtricks runtime directory.
    default: '{km_dir}'
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
stdout: kmtricks_repart.out
