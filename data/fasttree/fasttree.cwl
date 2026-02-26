cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastTree
label: fasttree
doc: "FastTree infers approximately-maximum-likelihood phylogenetic trees from alignments
  of nucleotide or protein sequences.\n\nTool homepage: https://morgannprice.github.io/fasttree"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Input alignment file (usually FASTA or Phylip format)
    inputBinding:
      position: 1
  - id: fastest
    type:
      - 'null'
      - boolean
    doc: Use a faster search
    inputBinding:
      position: 102
      prefix: -fastest
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: Use the Gamma20 likelihood (slower)
    inputBinding:
      position: 102
      prefix: -gamma
  - id: gtr
    type:
      - 'null'
      - boolean
    doc: Use the generalized time-reversible model (nucleotides only)
    inputBinding:
      position: 102
      prefix: -gtr
  - id: log_file
    type:
      - 'null'
      - File
    doc: Save intermediate results to logfile
    inputBinding:
      position: 102
      prefix: -log
  - id: model_mtr
    type:
      - 'null'
      - boolean
    doc: Use the Jukes-Cantor + CAT model (default for nucleotides)
    inputBinding:
      position: 102
      prefix: -mtr
  - id: model_wag
    type:
      - 'null'
      - boolean
    doc: Use the WAG + CAT model (default for amino acids)
    inputBinding:
      position: 102
      prefix: -wag
  - id: n_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates
    inputBinding:
      position: 102
      prefix: -n
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not write progress to standard error
    inputBinding:
      position: 102
      prefix: -nopr
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: Use nucleotide alignment (default is protein)
    inputBinding:
      position: 102
      prefix: -nt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write to standard error
    inputBinding:
      position: 102
      prefix: -quiet
  - id: slow
    type:
      - 'null'
      - boolean
    doc: Use a more exhaustive search
    inputBinding:
      position: 102
      prefix: -slow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasttree:2.2.0--h7b50bb2_1
stdout: fasttree.out
