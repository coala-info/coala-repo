cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassiopee
label: cassiopee
doc: "Cassiopee Version 1.0\n\nTool homepage: https://github.com/osallou/cassiopee-c"
inputs:
  - id: allow_alphabet_ambiguity
    type:
      - 'null'
      - boolean
    doc: allow alphabet ambiguity search
    inputBinding:
      position: 101
      prefix: -a
  - id: apply_morphisms
    type:
      - 'null'
      - boolean
    doc: apply morphisms to pattern
    inputBinding:
      position: 101
      prefix: -b
  - id: apply_tree_reduction
    type:
      - 'null'
      - boolean
    doc: apply tree reduction
    inputBinding:
      position: 101
      prefix: -r
  - id: generate_dot_file
    type:
      - 'null'
      - boolean
    doc: generates a dot file of the graph
    inputBinding:
      position: 101
      prefix: -g
  - id: max_consecutive_n
    type:
      - 'null'
      - int
    doc: max consecutive N allowed matches in search
    inputBinding:
      position: 101
      prefix: -n
  - id: max_graph_depth
    type:
      - 'null'
      - int
    doc: max depth of the graph
    inputBinding:
      position: 101
      prefix: -d
  - id: max_indel
    type:
      - 'null'
      - int
    doc: max indel allowed matches in search
    inputBinding:
      position: 101
      prefix: -i
  - id: max_index_depth
    type:
      - 'null'
      - int
    doc: maximum index depth / max pattern size
    inputBinding:
      position: 101
      prefix: -l
  - id: max_position
    type:
      - 'null'
      - int
    doc: maximum position in sequence
    inputBinding:
      position: 101
      prefix: -y
  - id: max_substitution
    type:
      - 'null'
      - int
    doc: max substitution allowed matches in search
    inputBinding:
      position: 101
      prefix: -e
  - id: min_position
    type:
      - 'null'
      - int
    doc: minimum position in sequence
    inputBinding:
      position: 101
      prefix: -x
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'output format: 0:tsv (default), 1:json'
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: pattern
    type:
      - 'null'
      - string
    doc: pattern to search
    inputBinding:
      position: 101
      prefix: -p
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: file containing pattern to search
    inputBinding:
      position: 101
      prefix: -f
  - id: save_index
    type:
      - 'null'
      - boolean
    doc: save index for later use
    inputBinding:
      position: 101
      prefix: -u
  - id: search_mode
    type:
      - 'null'
      - int
    doc: 'search mode: 0=DNA, 1=RNA, 2=Protein'
    inputBinding:
      position: 101
      prefix: -m
  - id: sequence
    type:
      - 'null'
      - string
    doc: sequence to index
    inputBinding:
      position: 101
      prefix: -s
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
    dockerPull: biocontainers/cassiopee:v1.0.9-2-deb_cv1
