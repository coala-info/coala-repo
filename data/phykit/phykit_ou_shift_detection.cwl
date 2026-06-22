cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - l1ou
label: phykit_ou_shift_detection
doc: Automatic OU shift detection using LASSO (l1ou approach). Discovers where 
  on the phylogeny the adaptive optimum changed, using the LASSO-based approach 
  from Khabbazian et al. (2016). No regime file is needed — only a tree and 
  trait data.
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
  - id: criterion
    type:
      - 'null'
      - string
    doc: 'model selection criterion: pBIC (default), BIC, or AICc'
    inputBinding:
      position: 101
      prefix: --criterion
  - id: max_shifts
    type:
      - 'null'
      - int
    doc: 'maximum number of shifts to consider (default: n/2)'
    inputBinding:
      position: 101
      prefix: --max-shifts
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
stdout: phykit_ou_shift_detection.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
