cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasamba_train
label: rnasamba_train
doc: "Train a new classification model.\n\nTool homepage: https://github.com/apcamargo/RNAsamba"
inputs:
  - id: output_file
    type: File
    doc: output HDF5 file containing weights of the newly trained RNAsamba 
      network.
    inputBinding:
      position: 1
  - id: coding_file
    type: File
    doc: input FASTA file containing sequences of protein- coding transcripts.
    inputBinding:
      position: 2
  - id: noncoding_file
    type: File
    doc: input FASTA file containing sequences of noncoding transcripts.
    inputBinding:
      position: 3
  - id: batch_size
    type:
      - 'null'
      - int
    doc: number of samples per gradient update.
    default: 128
    inputBinding:
      position: 104
      prefix: --batch_size
  - id: early_stopping
    type:
      - 'null'
      - int
    doc: number of epochs after lowest validation loss before stopping training 
      (a fraction of 0.1 of the training set is set apart for validation and the
      model with the lowest validation loss will be saved).
    default: 0
    inputBinding:
      position: 104
      prefix: --early_stopping
  - id: epochs
    type:
      - 'null'
      - int
    doc: number of epochs to train the model.
    default: 40
    inputBinding:
      position: 104
      prefix: --epochs
  - id: verbose
    type:
      - 'null'
      - int
    doc: print the progress of the training. 0 = silent, 1 = current step, 2 = 
      progress bar, 3 = one line per epoch.
    default: 0
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasamba:0.2.5--py36h91eb985_1
stdout: rnasamba_train.out
