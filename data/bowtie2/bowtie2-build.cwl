cwlVersion: v1.2
class: CommandLineTool
baseCommand: bowtie2-build
label: bowtie2-build
doc: "Builds a Bowtie 2 index from a set of DNA sequences.\n\nTool homepage: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml"
inputs:
  - id: reference_in
    type: string
    doc: comma-separated list of files with ref sequences
    inputBinding:
      position: 1
  - id: bmax
    type:
      - 'null'
      - int
    doc: max bucket sz for blockwise suffix-array builder
    inputBinding:
      position: 102
      prefix: --bmax
  - id: bmaxdivn
    type:
      - 'null'
      - int
    doc: max bucket sz as divisor of ref len
    default: 4
    inputBinding:
      position: 102
      prefix: --bmaxdivn
  - id: dcv
    type:
      - 'null'
      - int
    doc: diff-cover period for blockwise
    default: 1024
    inputBinding:
      position: 102
      prefix: --dcv
  - id: debug
    type:
      - 'null'
      - boolean
    doc: use the debug binary; slower, assertions enabled
    inputBinding:
      position: 102
      prefix: --debug
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: reference files are Fasta (default)
    inputBinding:
      position: 102
      prefix: -f
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: '# of chars consumed in initial lookup'
    default: 10
    inputBinding:
      position: 102
      prefix: --ftabchars
  - id: just_ref
    type:
      - 'null'
      - boolean
    doc: just build .3/.4 index files
    inputBinding:
      position: 102
      prefix: --justref
  - id: large_index
    type:
      - 'null'
      - boolean
    doc: force generated index to be 'large', even if ref has fewer than 4 billion
      nucleotides
    inputBinding:
      position: 102
      prefix: --large-index
  - id: no_auto
    type:
      - 'null'
      - boolean
    doc: disable automatic -p/--bmax/--dcv memory-fitting
    inputBinding:
      position: 102
      prefix: --noauto
  - id: no_dc
    type:
      - 'null'
      - boolean
    doc: disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 102
      prefix: --nodc
  - id: no_ref
    type:
      - 'null'
      - boolean
    doc: don't build .3/.4 index files
    inputBinding:
      position: 102
      prefix: --noref
  - id: offrate
    type:
      - 'null'
      - int
    doc: SA is sampled every 2^<int> BWT chars
    default: 5
    inputBinding:
      position: 102
      prefix: --offrate
  - id: packed
    type:
      - 'null'
      - boolean
    doc: use packed strings internally; slower, less memory
    inputBinding:
      position: 102
      prefix: --packed
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: verbose output (for debugging)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference_is_sequences
    type:
      - 'null'
      - boolean
    doc: reference sequences given on cmd line (as <reference_in>)
    inputBinding:
      position: 102
      prefix: -c
  - id: sanitized
    type:
      - 'null'
      - boolean
    doc: use sanitized binary; slower, uses ASan and/or UBSan
    inputBinding:
      position: 102
      prefix: --sanitized
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: '# of threads'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: log the issued command
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: bt2_index_base
    type: File
    doc: write bt2 data to files with this dir/basename
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bowtie2:2.5.4--h7071971_4
