cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mashpit
  - query
label: mashpit_query
doc: "Query a mashpit database for the isolates most similar to a sample genome and
  write a table and a mashtree neighbour-joining tree.\n\nTool homepage: https://github.com/tongzhouxu/mashpit"
inputs:
  - id: sample
    type: File
    doc: file path to the query sample (FASTA). Staged writable because mashpit
      writes the sample signature beside it.
    inputBinding:
      position: 1
  - id: database
    type: Directory
    doc: path to the database folder (made by mashpit build)
    inputBinding:
      position: 2
  - id: number
    type:
      - 'null'
      - int
    doc: number of isolates in the query output, default is 200
    inputBinding:
      position: 101
      prefix: --number
  - id: threshold
    type:
      - 'null'
      - float
    doc: minimum jaccard similarity for mashtree, default is 0.85
    inputBinding:
      position: 101
      prefix: --threshold
  - id: annotation
    type:
      - 'null'
      - string
    doc: mashtree tip annotation, default is none
    inputBinding:
      position: 101
      prefix: --annotation
outputs:
  - id: output_table
    type:
      - 'null'
      - type: array
        items: File
    doc: Query result table (<sample>_output.csv)
    outputBinding:
      glob: '*_output.csv'
  - id: tree
    type:
      - 'null'
      - type: array
        items: File
    doc: Tree of the query and its closest isolates (newick and png)
    outputBinding:
      glob: '*_tree.*'
  - id: log
    type:
      - 'null'
      - type: array
        items: File
    doc: Log file written by mashpit
    outputBinding:
      glob: mashpit-*.log
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashpit:0.9.10--pyhdfd78af_1
