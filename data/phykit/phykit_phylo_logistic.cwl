cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_logistic
label: phykit_phylo_logistic
doc: Fit a Phylogenetic Logistic Regression for binary (0/1) response data while
  accounting for phylogenetic non-independence among species (Ives & Garland 
  2010).
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
      prefix: --trait-data
  - id: response
    type: string
    doc: binary response column name (must contain only 0 and 1)
    inputBinding:
      position: 101
      prefix: --response
  - id: predictor
    type:
      type: array
      items: string
    doc: predictor column name(s), comma-separated for multiple
    inputBinding:
      position: 101
      prefix: --predictor
  - id: method
    type:
      - 'null'
      - string
    doc: 'estimation method: logistic_MPLE or logistic_IG10'
    inputBinding:
      position: 101
      prefix: --method
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
stdout: phykit_phylo_logistic.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
