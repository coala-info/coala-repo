cwlVersion: v1.2
class: CommandLineTool
baseCommand: parm predict
label: parm_predict
doc: "Promoter Activity Regulatory Model\n\nTool homepage: https://github.com/vansteensellab/PARM"
inputs:
  - id: filter_size
    type:
      - 'null'
      - int
    doc: The model size that torch expects
    default: 125
    inputBinding:
      position: 101
      prefix: --filter_size
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: If this flag is set, the output file will not contain the sequences of 
      the input fasta. By default, PARM shows both the sequence and the header.
    inputBinding:
      position: 101
      prefix: --header_only
  - id: input
    type: File
    doc: Path to the input fasta file with the sequences to be predicted.
    inputBinding:
      position: 101
      prefix: --input
  - id: l_max
    type:
      - 'null'
      - int
    doc: The maximum length of the sequences allowed by the model. All 
      pre-trained models have `--L_max 600`. However, if you trained your own 
      PARM model with a different L_max value, you should specify it here.
    default: 600
    inputBinding:
      position: 101
      prefix: --L_max
  - id: model
    type: File
    doc: Path to the directory of the model. If you want to perform predictions 
      for the pre-trained K562 model, for instance, this should be 
      pre_trained_models/K562. If you have trained your own model, you should 
      pass the path to the directory where the .parm files are stored.
    inputBinding:
      position: 101
      prefix: --model
  - id: n_seqs_per_batch
    type:
      - 'null'
      - int
    doc: Number of sequences to predict simultaneously, increase only if your 
      memory allows it.
    default: 1
    inputBinding:
      position: 101
      prefix: --n_seqs_per_batch
  - id: no_header_only
    type:
      - 'null'
      - boolean
    doc: If this flag is set, the output file will not contain the sequences of 
      the input fasta. By default, PARM shows both the sequence and the header.
    inputBinding:
      position: 101
      prefix: --no-header_only
  - id: no_predict_test_fold
    type:
      - 'null'
      - boolean
    doc: If this flag is set, PARM will assume the input is the hdf5 file of the
      test fold of a trained model. This is useful if you want to evaluate the 
      performance of a model that you trained.
    default: false
    inputBinding:
      position: 101
      prefix: --no-predict_test_fold
  - id: predict_test_fold
    type:
      - 'null'
      - boolean
    doc: If this flag is set, PARM will assume the input is the hdf5 file of the
      test fold of a trained model. This is useful if you want to evaluate the 
      performance of a model that you trained.
    default: false
    inputBinding:
      position: 101
      prefix: --predict_test_fold
  - id: type_loss
    type:
      - 'null'
      - string
    doc: Type of loss function to use for the model. Default is "poisson". Other
      options are "MSE" and "heteroscedastic".
    default: poisson
    inputBinding:
      position: 101
      prefix: --type_loss
outputs:
  - id: output
    type: File
    doc: Path to the output file where the predictions will be saved. Output is 
      a tab-separated file with the sequence, header, and the predicted score.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
