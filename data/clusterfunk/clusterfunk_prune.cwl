cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - prune
label: clusterfunk_prune
doc: "Prune or extract subtrees from a phylogenetic tree based on taxa sets, metadata,
  or traits.\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs:
  - id: collapse_to_polytomies
    type:
      - 'null'
      - float
    doc: A optional flag to collapse branches with length <= the input before 
      running the rule.
    inputBinding:
      position: 101
      prefix: --collapse_to_polytomies
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Boolean flag to extract and return the subtree defined by the taxa
    inputBinding:
      position: 101
      prefix: --extract
  - id: fasta
    type:
      - 'null'
      - File
    doc: incoming fasta file defining taxon set
    inputBinding:
      position: 101
      prefix: --fasta
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    inputBinding:
      position: 101
      prefix: --format
  - id: index_column
    type:
      - 'null'
      - string
    doc: column of metadata that holds the taxon names
    inputBinding:
      position: 101
      prefix: --index-column
  - id: input_tree
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: metadata
    type:
      - 'null'
      - File
    doc: incoming csv/tsv file defining taxon set.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: parse_data_key
    type:
      - 'null'
      - string
    doc: regex defined group(s) to construct keys from the data file to match 
      the taxon labels
    inputBinding:
      position: 101
      prefix: --parse-data-key
  - id: parse_taxon_key
    type:
      - 'null'
      - string
    doc: regex defined group(s) to construct keys from the taxon labels to match
      the data file keys
    inputBinding:
      position: 101
      prefix: --parse-taxon-key
  - id: taxon
    type:
      - 'null'
      - File
    doc: incoming text file defining taxon set with a new taxon on each line
    inputBinding:
      position: 101
      prefix: --taxon
  - id: trait
    type:
      - 'null'
      - string
    doc: A discrete trait. The tree will be pruned the tree for each value of 
      the trait. In this case the output will be interpreted as a directory.
    inputBinding:
      position: 101
      prefix: --trait
  - id: where_trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxa defined by annotation value
    inputBinding:
      position: 101
      prefix: --where-trait
outputs:
  - id: output
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
