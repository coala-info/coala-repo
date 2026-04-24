cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pin_hic
  - build
label: pin_hic_build
doc: "Build scaffolding graph using Hi-C links matrix\n\nTool homepage: https://github.com/dfguan/pin_hic/"
inputs:
  - id: links_matrix
    type: File
    doc: Links matrix file
    inputBinding:
      position: 1
  - id: accurate_mode
    type:
      - 'null'
      - boolean
    doc: Hi-C scaffolding in accurate mode
    inputBinding:
      position: 102
      prefix: -a
  - id: ignore_middle
    type:
      - 'null'
      - boolean
    doc: ignore middle part of contigs
    inputBinding:
      position: 102
      prefix: -g
  - id: max_linking_candidates
    type:
      - 'null'
      - int
    doc: maximum linking candiates
    inputBinding:
      position: 102
      prefix: -k
  - id: min_weight
    type:
      - 'null'
      - int
    doc: minimum weight for links
    inputBinding:
      position: 102
      prefix: -w
  - id: min_weight_diff
    type:
      - 'null'
      - float
    doc: minimum weight difference
    inputBinding:
      position: 102
      prefix: -f
  - id: normalize_weight
    type:
      - 'null'
      - boolean
    doc: normalize weight
    inputBinding:
      position: 102
      prefix: -n
  - id: reference_index
    type:
      - 'null'
      - File
    doc: reference index file
    inputBinding:
      position: 102
      prefix: -c
  - id: sat_file
    type:
      - 'null'
      - File
    doc: sat file
    inputBinding:
      position: 102
      prefix: -s
  - id: use_mst
    type:
      - 'null'
      - boolean
    doc: use MST to construct scaffolding graph [only for pin_hic]
    inputBinding:
      position: 102
      prefix: '-1'
  - id: use_normalized_edge_weight
    type:
      - 'null'
      - boolean
    doc: use normalized weight as edge weight
    inputBinding:
      position: 102
      prefix: -e
  - id: use_product_length
    type:
      - 'null'
      - boolean
    doc: use product of length
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
