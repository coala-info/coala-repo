cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy_util
label: rust-ncbitaxonomy_taxonomy_util_common_ancestor_distance
doc: "find the tree distance to te common ancestor between two taxa\n\nTool homepage: https://github.com/pvanheus/ncbitaxonomy"
arguments:
  - position: 2
    valueFrom: common_ancestor_distance
inputs:
  - id: db
    type: File
    doc: SQLite taxonomy database (made with taxonomy_util to_sqlite)
    inputBinding:
      position: 1
      prefix: --db
  - id: only_canonical
    type:
      - 'null'
      - boolean
    doc: Only consider canonical taxonomic ranks
    inputBinding:
      position: 3
      prefix: --only_canonical
  - id: name1
    type: string
    doc: Name of first taxon
    inputBinding:
      position: 4
  - id: name2
    type: string
    doc: Name of second taxon
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-ncbitaxonomy:1.0.7--hf9427c6_6
stdout: rust-ncbitaxonomy_taxonomy_util_common_ancestor_distance.out
