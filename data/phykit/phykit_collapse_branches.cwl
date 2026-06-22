cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - collapse_branches
label: phykit_collapse_branches
doc: Collapse branches on a phylogeny according to bipartition support. 
  Bipartitions will be collapsed if they are less than the user specified value.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be an tree file
    inputBinding:
      position: 1
  - id: support
    type: float
    doc: bipartitions with support less than this value will be collapsed
    inputBinding:
      position: 102
      prefix: --support
  - id: output
    type: string
    doc: optional argument to name the outputted tree file. Default output will 
      have the same name as the input file but with the suffix 
      ".collapsed_(support).tre"
    inputBinding:
      position: 102
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: optional argument to name the outputted tree file. Default output will 
      have the same name as the input file but with the suffix 
      ".collapsed_(support).tre"
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
