cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - random-sample
label: cooltools_random-sample
doc: "Pick a random sample of contacts from a Hi-C map.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: in_path
    type: File
    doc: Input cooler path or URI.
    inputBinding:
      position: 1
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "The number of pixels loaded and processed per step of\n                \
      \       computation."
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: cis_count
    type:
      - 'null'
      - int
    doc: "The target number of cis contacts in the sample. The\n                 \
      \      resulting sample size will not match it precisely.\n                \
      \       Mutually exclusive with --count and --frac"
    inputBinding:
      position: 102
      prefix: --cis-count
  - id: count
    type:
      - 'null'
      - int
    doc: "The target number of contacts in the sample. The\n                     \
      \  resulting sample size will not match it precisely.\n                    \
      \   Mutually exclusive with --frac and --cis-count"
    inputBinding:
      position: 102
      prefix: --count
  - id: exact
    type:
      - 'null'
      - boolean
    doc: "If specified, use exact sampling that guarantees the\n                 \
      \      size of the output sample. Otherwise, binomial sampling\n           \
      \            will be used and the sample size will be distributed\n        \
      \               around the target value."
    inputBinding:
      position: 102
      prefix: --exact
  - id: frac
    type:
      - 'null'
      - float
    doc: "The target sample size as a fraction of contacts in the\n              \
      \         original dataset. Mutually exclusive with --count and\n          \
      \             --cis-count"
    inputBinding:
      position: 102
      prefix: --frac
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    inputBinding:
      position: 102
      prefix: --nproc
outputs:
  - id: out_path
    type: File
    doc: Output cooler path or URI.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
