cwlVersion: v1.2
class: CommandLineTool
baseCommand: scpred-cli_scpred_get_feature_space.R
label: scpred-cli_scpred_get_feature_space.R
doc: "Get the feature space for scPred\n\nTool homepage: https://github.com/ebi-gene-expression-group/scPred-cli"
inputs:
  - id: correction_method
    type:
      - 'null'
      - string
    doc: Multiple testing correction method.
    default: fdr
    inputBinding:
      position: 101
      prefix: --correction-method
  - id: input_object
    type: File
    doc: Path to the input object of Seurat class in .rds format
    inputBinding:
      position: 101
      prefix: --input-object
  - id: prediction_column
    type: string
    doc: Name of the metadata column that contains cell labels
    inputBinding:
      position: 101
      prefix: --prediction-column
  - id: reduction_parameter
    type:
      - 'null'
      - string
    doc: Name of reduction in Seurat objet to be used to determine the feature 
      space.
    default: pca
    inputBinding:
      position: 101
      prefix: --reduction-parameter
  - id: significance_threshold
    type:
      - 'null'
      - float
    doc: Significance threshold for principal components explaining class 
      identity
    inputBinding:
      position: 101
      prefix: --significance-threshold
outputs:
  - id: output_path
    type: File
    doc: Path for the modified scPred object in .rds format
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
