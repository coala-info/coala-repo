cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsignal_plant
  - train
label: deepsignal-plant_train
doc: "train a model, need two independent datasets for training and validating\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs:
  - id: train_file
    type: File
    doc: "training samples (features from extract)"
    inputBinding:
      position: 101
      prefix: --train_file
  - id: valid_file
    type: File
    doc: "validation samples (features from extract)"
    inputBinding:
      position: 101
      prefix: --valid_file
  - id: model_dir
    type: string
    doc: "output directory for the trained models"
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: model_type
    type:
      - 'null'
      - string
    doc: "type of model to use, 'both_bilstm', 'seq_bilstm' or 'signal_bilstm', 'both_bilstm' means to use both seq and signal bilstm"
    inputBinding:
      position: 101
      prefix: --model_type
  - id: seq_len
    type:
      - 'null'
      - int
    doc: "len of kmer. default 13"
    inputBinding:
      position: 101
      prefix: --seq_len
  - id: signal_len
    type:
      - 'null'
      - int
    doc: "the number of signals of one base to be used in deepsignal_plant, default 16"
    inputBinding:
      position: 101
      prefix: --signal_len
  - id: layernum1
    type:
      - 'null'
      - int
    doc: "lstm layer num for combined feature, default 3"
    inputBinding:
      position: 101
      prefix: --layernum1
  - id: layernum2
    type:
      - 'null'
      - int
    doc: "lstm layer num for seq feature (and for signal feature too), default 1"
    inputBinding:
      position: 101
      prefix: --layernum2
  - id: class_num
    type:
      - 'null'
      - int
    doc: "number of classes"
    inputBinding:
      position: 101
      prefix: --class_num
  - id: dropout_rate
    type:
      - 'null'
      - float
    doc: "dropout rate"
    inputBinding:
      position: 101
      prefix: --dropout_rate
  - id: n_vocab
    type:
      - 'null'
      - int
    doc: "base_seq vocab_size (15 base kinds from iupac)"
    inputBinding:
      position: 101
      prefix: --n_vocab
  - id: n_embed
    type:
      - 'null'
      - int
    doc: "base_seq embedding_size"
    inputBinding:
      position: 101
      prefix: --n_embed
  - id: is_base
    type:
      - 'null'
      - string
    doc: "is using base features in seq model, default yes"
    inputBinding:
      position: 101
      prefix: --is_base
  - id: is_signallen
    type:
      - 'null'
      - string
    doc: "is using signal length feature of each base in seq model, default yes"
    inputBinding:
      position: 101
      prefix: --is_signallen
  - id: hid_rnn
    type:
      - 'null'
      - int
    doc: "BiLSTM hidden_size for combined feature"
    inputBinding:
      position: 101
      prefix: --hid_rnn
  - id: optim_type
    type:
      - 'null'
      - string
    doc: "type of optimizer to use, 'Adam' or 'SGD' or 'RMSprop' or 'Ranger', default Adam"
    inputBinding:
      position: 101
      prefix: --optim_type
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "batch size"
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: lr
    type:
      - 'null'
      - float
    doc: "learning rate"
    inputBinding:
      position: 101
      prefix: --lr
  - id: lr_decay
    type:
      - 'null'
      - float
    doc: "learning rate decay"
    inputBinding:
      position: 101
      prefix: --lr_decay
  - id: lr_decay_step
    type:
      - 'null'
      - int
    doc: "learning rate decay step"
    inputBinding:
      position: 101
      prefix: --lr_decay_step
  - id: max_epoch_num
    type:
      - 'null'
      - int
    doc: "max epoch num, default 10"
    inputBinding:
      position: 101
      prefix: --max_epoch_num
  - id: min_epoch_num
    type:
      - 'null'
      - int
    doc: "min epoch num, default 5"
    inputBinding:
      position: 101
      prefix: --min_epoch_num
  - id: step_interval
    type:
      - 'null'
      - int
    doc: "step interval"
    inputBinding:
      position: 101
      prefix: --step_interval
  - id: pos_weight
    type:
      - 'null'
      - float
    doc: "positive sample weight"
    inputBinding:
      position: 101
      prefix: --pos_weight
  - id: init_model
    type:
      - 'null'
      - File
    doc: "file path of pre-trained model parameters to load before training"
    inputBinding:
      position: 101
      prefix: --init_model
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "temporary directory"
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: model_output_dir
    type: Directory
    doc: directory with the trained models
    outputBinding:
      glob: $(inputs.model_dir)
  - id: models
    type: File[]
    doc: trained model checkpoints
    outputBinding:
      glob: $(inputs.model_dir)/*.ckpt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
