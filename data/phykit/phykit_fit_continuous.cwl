cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - fit_continuous
label: phykit_fit_continuous
doc: Compare models of continuous trait evolution on a phylogeny. Fits up to 7 
  models (BM, OU, EB, Lambda, Delta, Kappa, White) and ranks them by AIC, BIC, 
  and AIC weights — analogous to R's geiger::fitContinuous().
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
    doc: tab-delimited trait file (taxon<tab>value)
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of models to fit (BM, OU, EB, Lambda, Delta, 
      Kappa, White)
    inputBinding:
      position: 101
      prefix: --models
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
stdout: phykit_fit_continuous.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
