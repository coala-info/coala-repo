cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - branch_length_multiplier
label: phykit_branch_length_multiplier
doc: Multiply branch lengths in a phylogeny by a given factor. This can help 
  modify reference trees when conducting simulations or other analyses.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be an tree file
    inputBinding:
      position: 1
  - id: factor
    type: float
    doc: factor to multiply branch lengths by
    inputBinding:
      position: 102
      prefix: --factor
  - id: output
    type: string
    doc: optional argument to name the outputted tree file. Default output will 
      have the same name as the input file but with the suffix ".factor_(n).tre"
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
      have the same name as the input file but with the suffix ".factor_(n).tre"
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
