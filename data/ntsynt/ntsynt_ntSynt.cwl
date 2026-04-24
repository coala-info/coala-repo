cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntSynt
label: ntsynt_ntSynt
doc: "Multi-genome synteny detection using minimizer graphs\n\nTool homepage: https://github.com/bcgsc/ntsynt"
inputs:
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Input genome fasta files
    inputBinding:
      position: 1
  - id: benchmark
    type:
      - 'null'
      - boolean
    doc: Store benchmarks for each step of the ntSynt pipeline
    inputBinding:
      position: 102
      prefix: --benchmark
  - id: block_size
    type:
      - 'null'
      - int
    doc: Minimum synteny block size (bp)
    inputBinding:
      position: 102
      prefix: --block_size
  - id: dev
    type:
      - 'null'
      - boolean
    doc: Run in developer mode to retain intermediate files, log verbose output
    inputBinding:
      position: 102
      prefix: --dev
  - id: divergence
    type: float
    doc: "Approx. maximum percent sequence divergence between input genomes (Ex. -d
      1 for 1% divergence).\n                        This will be used to set --indel,
      --merge, --w_rounds, --block_size\n                        See below for default
      values - You can also set any of those parameters yourself, which will override
      these settings."
    inputBinding:
      position: 102
      prefix: --divergence
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Print out the commands that will be executed
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: fastas_list
    type:
      - 'null'
      - File
    doc: File listing input genome fasta files, one per line
    inputBinding:
      position: 102
      prefix: --fastas_list
  - id: force
    type:
      - 'null'
      - boolean
    doc: Run all ntSynt steps, regardless of existing output files
    inputBinding:
      position: 102
      prefix: --force
  - id: fpr
    type:
      - 'null'
      - float
    doc: False positive rate for Bloom filter creation
    inputBinding:
      position: 102
      prefix: --fpr
  - id: indel
    type:
      - 'null'
      - int
    doc: Threshold for indel detection (bp)
    inputBinding:
      position: 102
      prefix: --indel
  - id: k
    type:
      - 'null'
      - int
    doc: Minimizer k-mer size
    inputBinding:
      position: 102
      prefix: -k
  - id: merge
    type:
      - 'null'
      - int
    doc: "Maximum distance between collinear synteny blocks for merging (bp).\n  \
      \                      Can also specify a multiple of the window size (ex. 3w)"
    inputBinding:
      position: 102
      prefix: --merge
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for ntSynt output files [ntSynt.k<k>.w<w>]
    inputBinding:
      position: 102
      prefix: --prefix
  - id: t
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: w
    type:
      - 'null'
      - int
    doc: Minimizer window size
    inputBinding:
      position: 102
      prefix: -w
  - id: w_rounds
    type:
      - 'null'
      - type: array
        items: int
    doc: List of decreasing window sizes for synteny block refinement
    inputBinding:
      position: 102
      prefix: --w_rounds
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsynt:1.0.5--py310h184ae93_0
stdout: ntsynt_ntSynt.out
