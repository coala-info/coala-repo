cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scmap_get_std_output.R
label: scmap-cli_scmap_get_std_output.R
doc: "Get standard output from scmap predictions\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: include_scores
    type:
      - 'null'
      - boolean
    doc: Should prediction scores be included in output?
    default: 'FALSE'
    inputBinding:
      position: 101
      prefix: --include-scores
  - id: index
    type:
      - 'null'
      - File
    doc: Path to the index object in .rds format (Optional; required to add 
      dataset of origin to output table)
    inputBinding:
      position: 101
      prefix: --index
  - id: predictions_file
    type: File
    doc: Path to the predictions file in text format
    inputBinding:
      position: 101
      prefix: --predictions-file
  - id: sim_col_name
    type:
      - 'null'
      - string
    doc: Column name of similarity scores
    inputBinding:
      position: 101
      prefix: --sim-col-name
  - id: tool
    type:
      - 'null'
      - string
    doc: What tool produced output? scmap-cell or scmap-cluster
    inputBinding:
      position: 101
      prefix: --tool
outputs:
  - id: output_table
    type: File
    doc: Path to the final output file in text format
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
