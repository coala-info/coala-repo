cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - hclust
label: comparem_hclust
doc: "Perform hierarchical clustering.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: pairwise_value_file
    type: File
    doc: "file with pairwise similarity or dissimilarity values between genomes"
    inputBinding:
      position: 1
  - id: output_tree
    type: string
    doc: "name for output hierarchical cluster tree"
    inputBinding:
      position: 2
  - id: method
    type:
      - 'null'
      - string
    doc: "clustering method to use: single, complete, average, weighted, centroid, median, ward (default: average)"
    inputBinding:
      position: 101
      prefix: --method
  - id: similarity
    type:
      - 'null'
      - boolean
    doc: "indicates file contain similarity values"
    inputBinding:
      position: 101
      prefix: --similarity
  - id: max_sim_value
    type:
      - 'null'
      - float
    doc: "maximum similarity value (default: 100)"
    inputBinding:
      position: 101
      prefix: --max_sim_value
  - id: name_col1
    type:
      - 'null'
      - int
    doc: "index of first column with genome names (default: 0)"
    inputBinding:
      position: 101
      prefix: --name_col1
  - id: name_col2
    type:
      - 'null'
      - int
    doc: "index of second column with genome names (default: 1)"
    inputBinding:
      position: 101
      prefix: --name_col2
  - id: value_col
    type:
      - 'null'
      - int
    doc: "index of column with similarity or dissimilarity values (default: 2)"
    inputBinding:
      position: 101
      prefix: --value_col
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "suppress output"
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output
    type: File
    doc: "hierarchical cluster tree (Newick)"
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
