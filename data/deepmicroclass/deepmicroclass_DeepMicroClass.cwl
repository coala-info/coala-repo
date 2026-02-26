cwlVersion: v1.2
class: CommandLineTool
baseCommand: DeepMicroClass
label: deepmicroclass_DeepMicroClass
doc: "A deep learning framework for classifying metagenomic sequences\n\nTool homepage:
  https://github.com/chengsly/DeepMicroClass"
inputs:
  - id: mode
    type: string
    doc: 'Subcommand to run: test, train, or predict'
    inputBinding:
      position: 1
  - id: predict_class
    type:
      - 'null'
      - boolean
    doc: Predict the class of a sequence
    inputBinding:
      position: 102
      prefix: --predict
  - id: test_mode_settings
    type:
      - 'null'
      - boolean
    doc: Test the prediction function. It will use default settings to test 
      DeepMicroClass. And output the test result in the current working 
      directory. The expected result is in 
      /usr/local/lib/python3.12/site-packages/DeepMicroClass/demo/test.fa_pred_one-hot_hybrid.tsv
    inputBinding:
      position: 102
      prefix: --test
  - id: train_model
    type:
      - 'null'
      - boolean
    doc: Train the model
    inputBinding:
      position: 102
      prefix: --train
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
stdout: deepmicroclass_DeepMicroClass.out
