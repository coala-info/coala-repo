cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - nearest_neighbor_interchange
label: phykit_nearest_neighbor_interchange
doc: Generate all nearest neighbor interchange moves for a binary rooted tree. 
  The output file will also include the original phylogeny.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: name of output file that will contain all trees with the nearest 
      neighbor interchange moves. Default output will have the same name as the 
      input file but with the suffix ".NNIs"
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
    doc: name of output file that will contain all trees with the nearest 
      neighbor interchange moves. Default output will have the same name as the 
      input file but with the suffix ".NNIs"
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
