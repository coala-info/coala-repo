cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine_tool_outputs.R
label: cell-types-analysis_combine_tool_outputs.R
doc: "Combines standardized output TSV files from multiple classifiers.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: exclusions
    type: File
    doc: Path to the yaml file with excluded terms. Must contain fields 
      'unlabelled' and 'trivial_terms'
    inputBinding:
      position: 101
      prefix: --exclusions
  - id: input_dir
    type: Directory
    doc: 'Path to the directory with standardised output .tsv files from multiple
      classifiers. It is expected that input files follow the format: A_B_final-labs.tsv,
      where A is dataset or origin and B is classifier used to obtain predictions.'
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: scores
    type:
      - 'null'
      - boolean
    doc: 'Boolean: Are prediction scores available for the given method?'
    inputBinding:
      position: 101
      prefix: --scores
  - id: top_labels_num
    type: int
    doc: Number of top labels to keep
    inputBinding:
      position: 101
      prefix: --top-labels-num
outputs:
  - id: output_table
    type: File
    doc: Path to the output table in text format
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
