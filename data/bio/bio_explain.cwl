cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_explain
doc: "Search database by ontological name or GO/SO ids.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: Search database by ontological name or GO/SO ids.
    inputBinding:
      position: 1
  - id: build
    type:
      - 'null'
      - boolean
    doc: build a database of all gene and sequence ontology terms.
    inputBinding:
      position: 102
      prefix: --build
  - id: go
    type:
      - 'null'
      - boolean
    doc: Filter query for gene ontology terms.
    inputBinding:
      position: 102
      prefix: --go
  - id: lineage
    type:
      - 'null'
      - boolean
    doc: show the ontological lineage
    inputBinding:
      position: 102
      prefix: --lineage
  - id: plot
    type:
      - 'null'
      - string
    doc: Plot the network graph of the given GO term into the given file name.
    inputBinding:
      position: 102
      prefix: --plot
  - id: preload
    type:
      - 'null'
      - boolean
    doc: loads entire database in memory
    inputBinding:
      position: 102
      prefix: --preload
  - id: so
    type:
      - 'null'
      - boolean
    doc: Filter query for sequence ontology terms.
    inputBinding:
      position: 102
      prefix: --so
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode, prints more messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_explain.out
