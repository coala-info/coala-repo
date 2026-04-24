cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth train
label: ccsmeth_train
doc: "train a model, need two independent datasets for training and validating\n\n\
  Tool homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: class_num
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --class_num
  - id: d_model
    type:
      - 'null'
      - int
    doc: TransformerEncoder input feature numbers
    inputBinding:
      position: 101
      prefix: --d_model
  - id: dim_ff
    type:
      - 'null'
      - int
    doc: TransformerEncoder dim_feedforward
    inputBinding:
      position: 101
      prefix: --dim_ff
  - id: dl_num_workers
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --dl_num_workers
  - id: dl_offsets
    type:
      - 'null'
      - boolean
    doc: use file offsets loader
    inputBinding:
      position: 101
      prefix: --dl_offsets
  - id: dropout_rate
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --dropout_rate
  - id: hid_rnn
    type:
      - 'null'
      - int
    doc: BiRNN hidden_size
    inputBinding:
      position: 101
      prefix: --hid_rnn
  - id: init_model
    type:
      - 'null'
      - File
    doc: file path of pre-trained model parameters to load before training
    inputBinding:
      position: 101
      prefix: --init_model
  - id: is_map
    type:
      - 'null'
      - boolean
    doc: if using mapping features, yes or no
    inputBinding:
      position: 101
      prefix: --is_map
  - id: is_npass
    type:
      - 'null'
      - boolean
    doc: if using num_pass features, yes or no
    inputBinding:
      position: 101
      prefix: --is_npass
  - id: is_sn
    type:
      - 'null'
      - boolean
    doc: if using signal-to-noise-ratio features, yes or no
    inputBinding:
      position: 101
      prefix: --is_sn
  - id: is_stds
    type:
      - 'null'
      - boolean
    doc: if using std features, yes or no
    inputBinding:
      position: 101
      prefix: --is_stds
  - id: layer_rnn
    type:
      - 'null'
      - int
    doc: BiRNN layer num
    inputBinding:
      position: 101
      prefix: --layer_rnn
  - id: layer_trans
    type:
      - 'null'
      - int
    doc: TransformerEncoder nlayers
    inputBinding:
      position: 101
      prefix: --layer_trans
  - id: lr
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --lr
  - id: lr_decay
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --lr_decay
  - id: lr_decay_step
    type:
      - 'null'
      - int
    doc: effective in StepLR
    inputBinding:
      position: 101
      prefix: --lr_decay_step
  - id: lr_mode_strategy
    type:
      - 'null'
      - string
    doc: effective in ReduceLROnPlateau. last, mean, or max
    inputBinding:
      position: 101
      prefix: --lr_mode_strategy
  - id: lr_patience
    type:
      - 'null'
      - int
    doc: effective in ReduceLROnPlateau
    inputBinding:
      position: 101
      prefix: --lr_patience
  - id: lr_scheduler
    type:
      - 'null'
      - string
    doc: StepLR or ReduceLROnPlateau
    inputBinding:
      position: 101
      prefix: --lr_scheduler
  - id: max_epoch_num
    type:
      - 'null'
      - int
    doc: max epoch num
    inputBinding:
      position: 101
      prefix: --max_epoch_num
  - id: min_epoch_num
    type:
      - 'null'
      - int
    doc: min epoch num
    inputBinding:
      position: 101
      prefix: --min_epoch_num
  - id: model_dir
    type: Directory
    doc: Directory to save the trained model
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: model_type
    type:
      - 'null'
      - string
    doc: type of model to use, 'attbilstm2s', 'attbigru2s', 'transencoder2s', 
      'attbilstm2s2', 'attbigru2s2'
    inputBinding:
      position: 101
      prefix: --model_type
  - id: nhead
    type:
      - 'null'
      - int
    doc: TransformerEncoder nhead
    inputBinding:
      position: 101
      prefix: --nhead
  - id: optim_type
    type:
      - 'null'
      - string
    doc: type of optimizer to use, 'Adam', 'SGD', 'RMSprop', 'Ranger' or 
      'LookaheadAdam'
    inputBinding:
      position: 101
      prefix: --optim_type
  - id: pos_weight
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --pos_weight
  - id: seq_len
    type:
      - 'null'
      - int
    doc: length of kmer
    inputBinding:
      position: 101
      prefix: --seq_len
  - id: step_interval
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --step_interval
  - id: train_file
    type: File
    doc: Training data file
    inputBinding:
      position: 101
      prefix: --train_file
  - id: tseed
    type:
      - 'null'
      - int
    doc: random seed for pytorch
    inputBinding:
      position: 101
      prefix: --tseed
  - id: use_compile
    type:
      - 'null'
      - boolean
    doc: if using torch.compile, yes or no ('yes' only works in pytorch>=2.0)
    inputBinding:
      position: 101
      prefix: --use_compile
  - id: valid_file
    type: File
    doc: Validation data file
    inputBinding:
      position: 101
      prefix: --valid_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
stdout: ccsmeth_train.out
