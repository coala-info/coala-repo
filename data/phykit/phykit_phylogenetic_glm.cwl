cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylogenetic_glm
label: phykit_phylogenetic_glm
doc: Fit a Phylogenetic Generalized Linear Model (GLM) for binary or count 
  response data while accounting for phylogenetic non-independence among 
  species.
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
  - id: family
    type: string
    doc: 'distribution family: binomial or poisson'
    inputBinding:
      position: 101
      prefix: --family
  - id: method
    type:
      - 'null'
      - string
    doc: 'estimation method: logistic_MPLE or poisson_GEE (auto from family)'
    inputBinding:
      position: 101
      prefix: --method
  - id: btol
    type:
      - 'null'
      - int
    doc: linear predictor bound for logistic model
    inputBinding:
      position: 101
      prefix: --btol
  - id: log_alpha_bound
    type:
      - 'null'
      - int
    doc: bound on log(alpha*Tmax) for logistic model
    inputBinding:
      position: 101
      prefix: --log-alpha-bound
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
stdout: phykit_phylogenetic_glm.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
