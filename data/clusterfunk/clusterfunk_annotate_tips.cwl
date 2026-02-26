cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - annotate
label: clusterfunk_annotate_tips
doc: "Annotate tips and nodes in a phylogenetic tree using taxon labels, metadata
  files, or MRCA rules.\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
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
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    default: nexus
    inputBinding:
      position: 101
      prefix: --format
  - id: from_taxon
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of regex group(s) parsing trait values from taxon 
      label
    inputBinding:
      position: 101
      prefix: --from-taxon
  - id: in_metadata
    type:
      - 'null'
      - File
    doc: optional csv file with tip annotations
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type:
      - 'null'
      - string
    doc: What column in the csv should be used to match the tip names.
    inputBinding:
      position: 101
      prefix: --index-column
  - id: input
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: mrca
    type:
      - 'null'
      - type: array
        items: string
    doc: An optional list of traits for which the mrca of each value in each 
      traitwill be annotated with '[trait_name]-mrca and assigned that value
    inputBinding:
      position: 101
      prefix: --mrca
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
  - id: trait_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of columns to annotate on tree
    inputBinding:
      position: 101
      prefix: --trait-columns
  - id: where_trait
    type:
      - 'null'
      - type: array
        items: string
    doc: A boolean annotation will be added for each node with the new trait 
      specifying whether the annotation <trait> not it matches this value. the 
      new trait will be called <trait>_<qualifier>
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
