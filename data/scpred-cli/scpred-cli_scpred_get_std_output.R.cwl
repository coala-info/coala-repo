cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scpred_get_std_output.R
label: scpred-cli_scpred_get_std_output.R
doc: "Get standard output from SCPRED predictions.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scPred-cli"
inputs:
  - id: classifier
    type:
      - 'null'
      - File
    doc: Path to the classifier object in .rds format (Optional; required to add
      dataset of origin to output table)
    inputBinding:
      position: 101
      prefix: --classifier
  - id: get_scores
    type:
      - 'null'
      - boolean
    doc: Should score column be added?
    default: true
    inputBinding:
      position: 101
      prefix: --get-scores
  - id: predictions_object
    type: File
    doc: Path to the Seurat predictions object in .rds format
    inputBinding:
      position: 101
      prefix: --predictions-object
outputs:
  - id: output_table
    type: File
    doc: Path to the final output file in text format
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
