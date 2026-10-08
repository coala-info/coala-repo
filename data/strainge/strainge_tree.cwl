cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- tree
label: strainge_tree
doc: 'Build an approximate phylogenetic tree based on a given distance matrix, using neighbour joining.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: distance_matrix
  type: File
  doc: The path to the distance matrix TSV, as created by `straingr dist`.
  inputBinding:
    position: 100
- id: output
  type:
  - 'null'
  - string
  doc: Output filename. Defaults to stdout.
  inputBinding:
    position: 1
    prefix: --output
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: Output filename. Defaults to stdout.
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_tree.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
