cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - generate
label: enrichm_generate
doc: "Generate a random forest model from an annotation matrix and a file of groups.\n\nTool homepage: https://github.com/geronimp/enrichM"
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
  - id: input_matrix
    type: File
    doc: "input matrix of results"
    inputBinding:
      position: 1
      prefix: --input_matrix
  - id: groups
    type: File
    doc: "defined outcomes to train the data to"
    inputBinding:
      position: 1
      prefix: --groups
  - id: model_type
    type:
      type: enum
      symbols: [regressor, classifier]
    doc: "regressor or classifier"
    inputBinding:
      position: 1
      prefix: --model_type
  - id: testing_portion
    type:
      - 'null'
      - float
    doc: "portion of the input data to use for testing (default = 0.2)"
    inputBinding:
      position: 1
      prefix: --testing_portion
  - id: grid_search
    type:
      - 'null'
      - boolean
    doc: "grid search"
    inputBinding:
      position: 1
      prefix: --grid_search
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use for hyperparameterization (default = all available)"
    inputBinding:
      position: 1
      prefix: --threads
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
      glob: generate.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
