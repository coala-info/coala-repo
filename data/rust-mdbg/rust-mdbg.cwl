cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg
label: rust-mdbg
doc: "Original implementation of minimizer-space de Bruijn graphs (mdBG) for genome
  assembly.\n\nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs:
  - id: reads
    type: File
    doc: Input file (raw or gzip-/lz4-compressed FASTX)
    inputBinding:
      position: 1
  - id: bf
    type:
      - 'null'
      - boolean
    doc: Enable Bloom filters
    inputBinding:
      position: 102
      prefix: --bf
  - id: correction_threshold
    type:
      - 'null'
      - string
    doc: POA correction threshold
    inputBinding:
      position: 102
      prefix: --correction-threshold
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Activate debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: density
    type:
      - 'null'
      - string
    doc: Density threshold for density-based selection scheme
    inputBinding:
      position: 102
      prefix: --density
  - id: distance
    type:
      - 'null'
      - string
    doc: 'Distance metric (0: Jaccard, 1: containment, 2: Mash)'
    inputBinding:
      position: 102
      prefix: --distance
  - id: error_correct
    type:
      - 'null'
      - boolean
    doc: Enable error correction with minimizer-space POA
    inputBinding:
      position: 102
      prefix: --error-correct
  - id: hpc
    type:
      - 'null'
      - boolean
    doc: Homopolymer-compressed (HPC) input
    inputBinding:
      position: 102
      prefix: --hpc
  - id: k
    type:
      - 'null'
      - string
    doc: k-min-mer length
    inputBinding:
      position: 102
      prefix: --k
  - id: l
    type:
      - 'null'
      - string
    doc: l-mer (minimizer) length
    inputBinding:
      position: 102
      prefix: --l
  - id: lcp
    type:
      - 'null'
      - File
    doc: Core substring file (enables locally consistent parsing (LCP))
    inputBinding:
      position: 102
      prefix: --lcp
  - id: lmer_counts
    type:
      - 'null'
      - File
    doc: l-mer counts (enables downweighting of frequent l-mers)
    inputBinding:
      position: 102
      prefix: --lmer-counts
  - id: lmer_counts_max
    type:
      - 'null'
      - string
    doc: Maximum l-mer count threshold
    inputBinding:
      position: 102
      prefix: --lmer-counts-max
  - id: lmer_counts_min
    type:
      - 'null'
      - string
    doc: Minimum l-mer count threshold
    inputBinding:
      position: 102
      prefix: --lmer-counts-min
  - id: minabund
    type:
      - 'null'
      - string
    doc: Minimum k-min-mer abundance
    inputBinding:
      position: 102
      prefix: --minabund
  - id: n
    type:
      - 'null'
      - string
    doc: Tuple length for bucketing similar reads
    inputBinding:
      position: 102
      prefix: --n
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output prefix for GFA and .sequences files
    inputBinding:
      position: 102
      prefix: --prefix
  - id: presimp
    type:
      - 'null'
      - string
    doc: Pre-simplification (pre-simp) threshold
    inputBinding:
      position: 102
      prefix: --presimp
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Reference genome input
    inputBinding:
      position: 102
      prefix: --reference
  - id: restart_from_postcor
    type:
      - 'null'
      - boolean
    doc: Assemble error-corrected reads
    inputBinding:
      position: 102
      prefix: --restart-from-postcor
  - id: t
    type:
      - 'null'
      - string
    doc: POA path weight threshold
    inputBinding:
      position: 102
      prefix: --t
  - id: threads
    type:
      - 'null'
      - string
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: uhs
    type:
      - 'null'
      - File
    doc: Universal k-mer file (enables universal hitting sets (UHS))
    inputBinding:
      position: 102
      prefix: --uhs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg.out
