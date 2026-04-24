cwlVersion: v1.2
class: CommandLineTool
baseCommand: dna-brnn
label: dna-nn_dna-brnn
doc: "Reads a sequence file and performs training or prediction using a recurrent
  neural network.\n\nTool homepage: https://github.com/lh3/dna-nn"
inputs:
  - id: seq_fq
    type: File
    doc: Input sequence file in FASTQ format
    inputBinding:
      position: 1
  - id: bases_to_train_per_epoch
    type:
      - 'null'
      - int
    doc: number of bases to train per epoch
    inputBinding:
      position: 102
      prefix: -b
  - id: dropout_rate
    type:
      - 'null'
      - float
    doc: dropout rate
    inputBinding:
      position: 102
      prefix: -d
  - id: epochs
    type:
      - 'null'
      - int
    doc: number of epochs
    inputBinding:
      position: 102
      prefix: -m
  - id: gru_layers
    type:
      - 'null'
      - int
    doc: number of GRU layers
    inputBinding:
      position: 102
      prefix: -l
  - id: hidden_neurons
    type:
      - 'null'
      - int
    doc: number of hidden neurons
    inputBinding:
      position: 102
      prefix: -n
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: learning rate
    inputBinding:
      position: 102
      prefix: -r
  - id: min_signal_len
    type:
      - 'null'
      - int
    doc: min signal len (0 to disable)
    inputBinding:
      position: 102
      prefix: -L
  - id: mini_batch_size
    type:
      - 'null'
      - int
    doc: mini-batch size
    inputBinding:
      position: 102
      prefix: -B
  - id: predict
    type:
      - 'null'
      - boolean
    doc: predict using a trained model (req. -i)
    inputBinding:
      position: 102
      prefix: -A
  - id: predict_and_evaluate
    type:
      - 'null'
      - boolean
    doc: predict and evaluate a trained model (req. -i)
    inputBinding:
      position: 102
      prefix: -E
  - id: prng_seed
    type:
      - 'null'
      - int
    doc: PRNG seed
    inputBinding:
      position: 102
      prefix: -s
  - id: segment_overlap_length
    type:
      - 'null'
      - int
    doc: segment overlap length
    inputBinding:
      position: 102
      prefix: -O
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: trained_model_file
    type:
      - 'null'
      - File
    doc: Read a trained model from FILE
    inputBinding:
      position: 102
      prefix: -i
  - id: weight_false_positive
    type:
      - 'null'
      - float
    doc: weight on false positive errors
    inputBinding:
      position: 102
      prefix: -w
  - id: window_length
    type:
      - 'null'
      - int
    doc: window length
    inputBinding:
      position: 102
      prefix: -u
  - id: x_drop_len
    type:
      - 'null'
      - int
    doc: X-drop len (0 to disable)
    inputBinding:
      position: 102
      prefix: -X
outputs:
  - id: output_model_file
    type:
      - 'null'
      - File
    doc: Write model to FILE
    outputBinding:
      glob: $(inputs.output_model_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
