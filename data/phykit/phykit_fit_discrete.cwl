cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - fit_discrete
label: phykit_fit_discrete
doc: Compare models of discrete trait evolution on a phylogeny. Fits ER (Equal 
  Rates), SYM (Symmetric), and ARD (All Rates Different) Mk models of discrete 
  character evolution via maximum likelihood. Compares models using AIC and BIC.
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
    doc: trait data file in TSV format
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: trait
    type: string
    doc: column name for the discrete trait in the data file
    inputBinding:
      position: 101
      prefix: --trait
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of models to fit
    inputBinding:
      position: 101
      prefix: --models
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
stdout: phykit_fit_discrete.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
