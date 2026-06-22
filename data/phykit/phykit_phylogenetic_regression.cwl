cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylogenetic_regression
label: phykit_phylogenetic_regression
doc: Fit a Phylogenetic Generalized Least Squares (PGLS) regression while 
  accounting for phylogenetic non-independence among species, analogous to R's 
  caper::pgls().
inputs:
  - id: tree
    type: File
    doc: a tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: tab-delimited multi-trait file with header row
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: response
    type: string
    doc: response (dependent) variable column name
    inputBinding:
      position: 101
      prefix: --response
  - id: predictors
    type:
      type: array
      items: string
    doc: one or more predictor column names
    inputBinding:
      position: 101
      prefix: --predictors
  - id: method
    type:
      - 'null'
      - string
    doc: 'method to use: BM or lambda'
    inputBinding:
      position: 101
      prefix: --method
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: optional multi-Newick file of gene trees for discordance-aware VCV 
      computation
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_phylogenetic_regression.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
