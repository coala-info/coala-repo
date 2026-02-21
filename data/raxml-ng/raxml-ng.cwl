cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxml-ng
label: raxml-ng
doc: "RAxML-NG is a phylogenetic tree inference tool which uses maximum-likelihood
  (ML) optimality criterion.\n\nTool homepage: https://github.com/amkozlov/raxml-ng"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: All-in-one analysis (ML search + bootstrapping)
    inputBinding:
      position: 101
      prefix: --all
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Perform non-parametric bootstrap analysis
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: Evaluate log-likelihood of a given tree
    inputBinding:
      position: 101
      prefix: --evaluate
  - id: model
    type: string
    doc: Substitution model (e.g., GTR+G)
    inputBinding:
      position: 101
      prefix: --model
  - id: msa
    type: File
    doc: Alignment file (PHYLIP, FASTA, or CATG format)
    inputBinding:
      position: 101
      prefix: --msa
  - id: parse
    type:
      - 'null'
      - boolean
    doc: Check alignment and model, then compress to binary format
    inputBinding:
      position: 101
      prefix: --parse
  - id: search
    type:
      - 'null'
      - boolean
    doc: Perform ML tree search
    inputBinding:
      position: 101
      prefix: --search
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for parsimony trees and bootstrapping
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: Starting tree file (Newick format)
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: prefix
    type:
      - 'null'
      - File
    doc: Prefix for all output files
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml-ng:1.2.2--h6747034_2
