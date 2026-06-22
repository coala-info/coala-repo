cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - ouwie
label: phykit_ouwie
doc: Fit multi-regime Ornstein-Uhlenbeck models of continuous trait evolution 
  (Beaulieu et al. 2012), analogous to R's OUwie package.
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
  - id: regime_data
    type:
      - 'null'
      - File
    doc: tab-delimited regime file (taxon<tab>regime_label)
    inputBinding:
      position: 101
      prefix: --regime_data
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of models to fit (BM1, BMS, OU1, OUM, OUMV, OUMA, 
      OUMVA)
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
stdout: phykit_ouwie.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
