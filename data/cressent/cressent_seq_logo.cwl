cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - seq_logo
label: cressent_seq_logo
doc: "Generate a sequence logo from a FASTA file or sequence table.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: "Path to the fasta file."
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: seq_df
    type:
      - 'null'
      - File
    doc: "Path to the table produced by seqkit."
    inputBinding:
      position: 101
      prefix: --seq_df
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Name of the sequence logo (default: sequence_logo.pdf)"
    inputBinding:
      position: 101
      prefix: --output_name
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "Title of the Sequence Logo (default: sequence_logo)"
    inputBinding:
      position: 101
      prefix: --plot_title
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of the sequence logo (default = 10)"
    inputBinding:
      position: 101
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of the sequence logo (default = 10)"
    inputBinding:
      position: 101
      prefix: --height
  - id: split
    type:
      - 'null'
      - boolean
    doc: "If set, the sequence logo will be split by group label"
    inputBinding:
      position: 101
      prefix: --split
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Path to metadata file containing group labels."
    inputBinding:
      position: 101
      prefix: --metadata
  - id: ncol
    type:
      - 'null'
      - int
    doc: "Number of columns when splitting the sequence logo."
    inputBinding:
      position: 101
      prefix: --ncol
  - id: group_label
    type:
      - 'null'
      - string
    doc: "Column name in metadata for grouping sequences."
    inputBinding:
      position: 101
      prefix: --group_label
  - id: positions_per_row
    type:
      - 'null'
      - int
    doc: "Number of positions per row when creating multi-row plots (default: 50)"
    inputBinding:
      position: 101
      prefix: --positions_per_row
  - id: max_positions_single_row
    type:
      - 'null'
      - int
    doc: "Maximum number of positions before automatically splitting into multiple rows (default: 100)"
    inputBinding:
      position: 101
      prefix: --max_positions_single_row
  - id: method
    type:
      - 'null'
      - string
    doc: "Method for ggseqlogo: 'bits' for information content or 'prob' for probability (default: prob)"
    inputBinding:
      position: 101
      prefix: --method
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
