cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - motif
label: cressent_motif
doc: "Combined module for motif finding and sequence logo generation.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file with sequences."
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: pattern
    type: string
    doc: "Sequence pattern (regex) for motif searching."
    inputBinding:
      position: 101
      prefix: --pattern
  - id: table_name
    type:
      - 'null'
      - string
    doc: "Name of the file that will store motif positions (Default: pattern_positions.txt)"
    inputBinding:
      position: 101
      prefix: --table_name
  - id: remove_gaps
    type:
      - 'null'
      - boolean
    doc: "If set, removes gaps ('-') before searching for motifs."
    inputBinding:
      position: 101
      prefix: --remove-gaps
  - id: split_sequences
    type:
      - 'null'
      - boolean
    doc: "If set, the sequences will be split at the motif position."
    inputBinding:
      position: 101
      prefix: --split-sequences
  - id: generate_logo
    type:
      - 'null'
      - boolean
    doc: "If set, generate a sequence logo from the motif results."
    inputBinding:
      position: 101
      prefix: --generate-logo
  - id: logo_name
    type:
      - 'null'
      - string
    doc: "Name of the sequence logo PDF file (Default: sequence_logo.pdf)"
    inputBinding:
      position: 101
      prefix: --logo-name
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "Title of the Sequence Logo (Default: sequence_logo)"
    inputBinding:
      position: 101
      prefix: --plot-title
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of the sequence logo PDF file (Default = 10)"
    inputBinding:
      position: 101
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of the sequence logo PDF file (Default = 10)"
    inputBinding:
      position: 101
      prefix: --height
  - id: split_logo
    type:
      - 'null'
      - boolean
    doc: "If set, the sequence logo will be split by group label."
    inputBinding:
      position: 101
      prefix: --split-logo
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
      prefix: --group-label
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
