cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - internode_labeler
label: phykit_internode_labeler
doc: Appends numerical identifiers to bipartitions in place of support values. 
  This is helpful for pointing to specific internodes in supplementary files or 
  otherwise.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: optional argument to name the outputted tree file
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
    doc: optional argument to name the outputted tree file
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
