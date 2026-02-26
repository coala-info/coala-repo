cwlVersion: v1.2
class: CommandLineTool
baseCommand: scn-predict.R
label: singlecellnet-cli_scn-predict.R
doc: "Predict cell types using a trained classifier.\n\nTool homepage: https://github.com/ebi-gene-expression-group/singlecellnet-cli"
inputs:
  - id: input_classifier_object
    type: File
    doc: Path to the input classifier object in .rds format.
    inputBinding:
      position: 101
      prefix: --input-classifier-object
  - id: n_rand_prof
    type:
      - 'null'
      - int
    doc: The number of random profiles generated for evaluation process
    inputBinding:
      position: 101
      prefix: --n-rand-prof
  - id: query_expression_data
    type: File
    doc: Path to the SCE object containing expression data to be predicted.
    inputBinding:
      position: 101
      prefix: --query-expression-data
  - id: return_raw_output
    type:
      - 'null'
      - boolean
    doc: Should the output be returned in raw format (i.e. not transformed into 
      table)?
    default: false
    inputBinding:
      position: 101
      prefix: --return-raw-output
outputs:
  - id: prediction_output
    type: File
    doc: Output path to the predictions obtained from the classifier.
    outputBinding:
      glob: $(inputs.prediction_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
