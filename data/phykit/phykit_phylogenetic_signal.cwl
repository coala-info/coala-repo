cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylogenetic_signal
label: phykit_phylogenetic_signal
doc: Calculate phylogenetic signal for continuous trait data. Supports 
  Blomberg's K and Pagel's lambda methods.
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
    doc: tab-delimited trait file (taxon_name<tab>trait_value)
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: method
    type:
      - 'null'
      - string
    doc: 'method to use: blombergs_k or lambda'
    inputBinding:
      position: 101
      prefix: --method
  - id: permutations
    type:
      - 'null'
      - int
    doc: number of permutations for blombergs_k
    inputBinding:
      position: 101
      prefix: --permutations
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: optional multi-Newick file of gene trees for discordance-aware VCV 
      computation
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: multivariate
    type:
      - 'null'
      - boolean
    doc: compute K_mult (Adams 2014) for multivariate traits using a 
      multi-column TSV file
    inputBinding:
      position: 101
      prefix: --multivariate
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
stdout: phykit_phylogenetic_signal.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
