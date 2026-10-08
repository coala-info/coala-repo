cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ete3
  - annotate
label: ete3_annotate
doc: "Annotate tree nodes with features read from tab-separated files, or with NCBI
  taxonomy data (ETE tree toolkit command line).\n\nTool homepage: http://etetoolkit.org/"
inputs:
  - id: src_trees
    type:
      - 'null'
      - type: array
        items: File
    doc: a list of trees in newick format (filenames or quoted strings)
    inputBinding:
      position: 101
      prefix: -t
  - id: src_tree_list
    type:
      - 'null'
      - File
    doc: path to a file containing many source trees, one per line
    inputBinding:
      position: 101
      prefix: --src_tree_list
  - id: src_tree_attr
    type:
      - 'null'
      - string
    doc: attribute in source tree used as leaf name
    inputBinding:
      position: 101
      prefix: --src_tree_attr
  - id: src_attr_parser
    type:
      - 'null'
      - string
    doc: Perl regular expression wrapping the portion of the target attribute 
      that should be used.
    inputBinding:
      position: 101
      prefix: --src_attr_parser
  - id: src_tree_format
    type:
      - 'null'
      - int
    doc: newick format of the source trees
    inputBinding:
      position: 101
      prefix: --src_tree_format
  - id: ncbi
    type:
      - 'null'
      - boolean
    doc: annotate tree nodes using ncbi taxonomy database.
    inputBinding:
      position: 101
      prefix: --ncbi
  - id: taxid_attr
    type:
      - 'null'
      - string
    doc: attribute used as NCBI taxid number
    inputBinding:
      position: 101
      prefix: --taxid_attr
  - id: feature
    type:
      - 'null'
      - string
    doc: 'Feature to annotate, as "name:<feature> source:<tab file> type:<str|int|float|set|list>"
      fields (given as one value; quote it)'
    inputBinding:
      position: 101
      prefix: --feature
  - id: output
    type:
      - 'null'
      - string
    doc: Base output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0=totally quite, 1=errors only, 2=warning+errors, 3=info+warnings+errors
      4=debug'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
stdout: ete3_annotate.out
