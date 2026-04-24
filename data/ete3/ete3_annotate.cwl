cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ete3
  - annotate
label: ete3_annotate
doc: "Annotates a tree with information from external files.\n\nTool homepage: http://etetoolkit.org/"
inputs:
  - id: tree_file
    type: File
    doc: Path to the input tree file (e.g., Newick, PhyloXML).
    inputBinding:
      position: 1
  - id: annotation_files
    type:
      type: array
      items: File
    doc: One or more annotation files (e.g., CSV, TSV).
    inputBinding:
      position: 2
  - id: annotate_internal_nodes
    type:
      - 'null'
      - boolean
    doc: Annotate internal nodes as well as leaves.
    inputBinding:
      position: 103
      prefix: --annotate-internal-nodes
  - id: annotation_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter used in annotation files.
    inputBinding:
      position: 103
      prefix: --annotation-delimiter
  - id: annotation_header
    type:
      - 'null'
      - boolean
    doc: Indicates if annotation files have a header row.
    inputBinding:
      position: 103
      prefix: --annotation-header
  - id: annotation_key_column
    type:
      - 'null'
      - int
    doc: Column index (0-based) to use as the key in annotation files.
    inputBinding:
      position: 103
      prefix: --annotation-key-column
  - id: annotation_name
    type:
      - 'null'
      - string
    doc: Name to assign to the annotation data.
    inputBinding:
      position: 103
      prefix: --annotation-name
  - id: annotation_value_columns
    type:
      - 'null'
      - type: array
        items: int
    doc: Column indices (0-based) to use as values in annotation files.
    inputBinding:
      position: 103
      prefix: --annotation-value-columns
  - id: collapse_by
    type:
      - 'null'
      - string
    doc: Attribute to use for collapsing nodes.
    inputBinding:
      position: 103
      prefix: --collapse-by
  - id: collapse_threshold
    type:
      - 'null'
      - float
    doc: Threshold for collapsing nodes.
    inputBinding:
      position: 103
      prefix: --collapse-threshold
  - id: format
    type:
      - 'null'
      - string
    doc: Output tree format (e.g., newick, phyloxml).
    inputBinding:
      position: 103
      prefix: --format
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output annotated tree file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
