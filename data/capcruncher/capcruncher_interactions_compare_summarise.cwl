cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - compare
  - summarise
label: capcruncher_interactions_compare_summarise
doc: "Aggregate (summarise) concatenated viewpoint interactions by groups of samples, with optional subtraction between groups.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: infile
    type: File
    doc: "Concatenated interactions table (from compare concat)"
    inputBinding:
      position: 1
  - id: design_matrix
    type:
      - 'null'
      - File
    doc: "Design matrix file, tab separated, first column sample names, other column the conditions."
    inputBinding:
      position: 2
      prefix: -d
  - id: output_prefix
    type: string
    default: summary
    doc: "Output file prefix"
    inputBinding:
      position: 2
      prefix: -o
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format (bedgraph or tsv)"
    inputBinding:
      position: 2
      prefix: -f
  - id: summary_methods
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
    doc: "Summary methods to use for aggregation. Can be any method in numpy or scipy.stats"
    inputBinding:
      position: 2
  - id: group_names
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -n
    doc: "Group names for aggregation"
    inputBinding:
      position: 2
  - id: group_columns
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -c
    doc: "Column names/numbers (0 indexed, the first column after the end coordinate counts as 0) for aggregation."
    inputBinding:
      position: 2
  - id: subtraction
    type:
      - 'null'
      - boolean
    doc: "Perform subtraction between aggregated groups"
    inputBinding:
      position: 2
      prefix: --subtraction
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Add a suffix before the file extension"
    inputBinding:
      position: 2
      prefix: --suffix
outputs:
  - id: summaries
    type:
      type: array
      items: File
    doc: "Summarised bedgraph or tsv files"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
