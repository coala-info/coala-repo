cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - predict
label: enrichm_predict
doc: "Run a random forest model on new data.\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs:
  - id: log
    type:
      - 'null'
      - string
    doc: "Output logging information to this file."
    inputBinding:
      position: 1
      prefix: --log
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity (1 - 5 - default = 4) 5 = Very verbose, 1 = Silent"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: output
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous run"
    inputBinding:
      position: 1
      prefix: --force
  - id: forester_model_directory
    type: Directory
    doc: "Pickled model to use"
    inputBinding:
      position: 1
      prefix: --forester_model_directory
  - id: input_matrix
    type: File
    doc: "matrix of data to predict"
    inputBinding:
      position: 1
      prefix: --input_matrix
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written by the tool (named after the subcommand)
    outputBinding:
      glob: predict.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
