cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmindex
  - build
label: kmindex_build
doc: "Build index.\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs:
  - id: bitw
    type:
      - 'null'
      - int
    doc: "Number of bits per cell.\n                 - Abundances are indexed by log2
      classes (nb classes = 2^{bitw})\n                   For example, using --bitw
      3 resulting in the following classes:\n                     0 -> 0\n       \
      \              1 -> [1,2) \n                     2 -> [2,4) \n             \
      \        3 -> [4,8) \n                     4 -> [8,16) \n                  \
      \   5 -> [16,32) \n                     6 -> [32,64) \n                    \
      \ 7 -> [64,max(uint32_t))"
    inputBinding:
      position: 101
      prefix: --bitw
  - id: bloom_size
    type:
      - 'null'
      - string
    doc: Bloom filter size.
    inputBinding:
      position: 101
      prefix: --bloom-size
  - id: compress_intermediate
    type:
      - 'null'
      - boolean
    doc: Compress intermediate files.
    inputBinding:
      position: 101
      prefix: --cpr
  - id: fof_file
    type: string
    doc: kmtricks input file.
    inputBinding:
      position: 101
      prefix: --fof
  - id: from_index
    type:
      - 'null'
      - string
    doc: Use parameters from a pre-registered index.
    inputBinding:
      position: 101
      prefix: --from
  - id: hard_min
    type:
      - 'null'
      - int
    doc: Min abundance to keep a k-mer.
    inputBinding:
      position: 101
      prefix: --hard-min
  - id: index_path
    type: string
    doc: Global index path.
    inputBinding:
      position: 101
      prefix: --index
  - id: km_path
    type:
      - 'null'
      - string
    doc: "Path to kmtricks binary.\n                       - If empty, kmtricks is
      searched in $PATH and\n                         at the same location as the
      kmindex binary."
    inputBinding:
      position: 101
      prefix: --km-path
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of a k-mer. in [8, 255])
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minim_size
    type:
      - 'null'
      - int
    doc: Size of minimizers. in [4, 15]
    inputBinding:
      position: 101
      prefix: --minim-size
  - id: nb_cell
    type:
      - 'null'
      - int
    doc: Number of cells in counting Bloom filter.
    inputBinding:
      position: 101
      prefix: --nb-cell
  - id: nb_partitions
    type:
      - 'null'
      - int
    doc: Number of partitions (0=auto).
    inputBinding:
      position: 101
      prefix: --nb-partitions
  - id: register_as
    type: string
    doc: Index name.
    inputBinding:
      position: 101
      prefix: --register-as
  - id: run_dir
    type: string
    doc: kmtricks runtime directory. Use '@inplace' to build inside the global 
      index directory
    inputBinding:
      position: 101
      prefix: --run-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level [debug|info|warning|error].
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex_build.out
