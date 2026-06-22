cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_impute
label: phykit_phylo_impute
doc: Phylogenetic imputation of missing trait values using conditional 
  multivariate normal distributions. Captures both phylogenetic relationships 
  and between-trait correlations to predict missing values.
inputs:
  - id: tree
    type: File
    doc: tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: multi-trait TSV with header row; missing values marked as NA, ?, or 
      empty
    inputBinding:
      position: 101
      prefix: --trait-data
  - id: output
    type: string
    doc: output TSV file with imputed values
    inputBinding:
      position: 101
      prefix: --output
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: optional multi-Newick file of gene trees for discordance-aware VCV
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
  - id: output_output
    type: File
    doc: output TSV file with imputed values
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
