cwlVersion: v1.2
class: CommandLineTool
baseCommand: gafpack
label: gafpack
doc: "Project a GAF alignment file into coverage over GFA graph nodes\n\nTool homepage:
  https://github.com/pangenome/gafpack"
inputs:
  - id: coverage_column
    type:
      - 'null'
      - boolean
    doc: Emit graph coverage vector in a single column
    inputBinding:
      position: 101
      prefix: --coverage-column
  - id: gaf
    type: File
    doc: Input GAF alignment file
    inputBinding:
      position: 101
      prefix: --gaf
  - id: gfa
    type: File
    doc: Input GFA pangenome graph file (supports .gz/.bgz compression)
    inputBinding:
      position: 101
      prefix: --gfa
  - id: len_scale
    type:
      - 'null'
      - boolean
    doc: Scale coverage values by node length
    inputBinding:
      position: 101
      prefix: --len-scale
  - id: weight_queries
    type:
      - 'null'
      - boolean
    doc: Weight coverage by query group occurrences
    inputBinding:
      position: 101
      prefix: --weight-queries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gafpack:0.1.3--h4349ce8_0
stdout: gafpack.out
