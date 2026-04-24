cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth trainm
label: ccsmeth_trainm
doc: "[EXPERIMENTAL]train a model using multi gpus\n\nTool homepage: https://github.com/PengNi/ccsmeth"
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
  - id: dist_url
    type:
      - 'null'
      - string
    doc: url used to set up distributed training
    inputBinding:
      position: 101
      prefix: --dist-url
  - id: dl_num_workers
    type:
      - 'null'
      - int
    doc: default 0
    inputBinding:
      position: 101
      prefix: --dl_num_workers
  - id: dropout_rate
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --dropout_rate
  - id: epoch_sync
    type:
      - 'null'
      - boolean
    doc: if sync model params of gpu0 to other local gpus after per epoch
    inputBinding:
      position: 101
      prefix: --epoch_sync
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
      - string
    doc: if using mapping features, yes or no
    inputBinding:
      position: 101
      prefix: --is_map
  - id: is_npass
    type:
      - 'null'
      - string
    doc: if using num_pass features, yes or no
    inputBinding:
      position: 101
      prefix: --is_npass
  - id: is_sn
    type:
      - 'null'
      - string
    doc: if using signal-to-noise-ratio features, yes or no
    inputBinding:
      position: 101
      prefix: --is_sn
  - id: is_stds
    type:
      - 'null'
      - string
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
    doc: default 0.001. [lr should be lr*world_size when using multi gpus? or 
      lower batch_size?]
    inputBinding:
      position: 101
      prefix: --lr
  - id: lr_decay
    type:
      - 'null'
      - float
    doc: default 0.1
    inputBinding:
      position: 101
      prefix: --lr_decay
  - id: lr_decay_step
    type:
      - 'null'
      - int
    doc: effective in StepLR. default 1
    inputBinding:
      position: 101
      prefix: --lr_decay_step
  - id: lr_patience
    type:
      - 'null'
      - int
    doc: effective in ReduceLROnPlateau. default 0
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
    doc: max epoch num, default 50
    inputBinding:
      position: 101
      prefix: --max_epoch_num
  - id: min_epoch_num
    type:
      - 'null'
      - int
    doc: min epoch num, default 10
    inputBinding:
      position: 101
      prefix: --min_epoch_num
  - id: model_dir
    type: Directory
    doc: MODEL_DIR
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
  - id: ngpus_per_node
    type:
      - 'null'
      - int
    doc: number of GPUs per node for distributed training, default 2
    inputBinding:
      position: 101
      prefix: --ngpus_per_node
  - id: nhead
    type:
      - 'null'
      - int
    doc: TransformerEncoder nhead
    inputBinding:
      position: 101
      prefix: --nhead
  - id: node_rank
    type:
      - 'null'
      - int
    doc: node rank for distributed training, default 0
    inputBinding:
      position: 101
      prefix: --node_rank
  - id: nodes
    type:
      - 'null'
      - int
    doc: number of nodes for distributed training, default 1
    inputBinding:
      position: 101
      prefix: --nodes
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
    doc: len of kmer.
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
    doc: TRAIN_FILE
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
      - string
    doc: if using torch.compile, yes or no, default no ('yes' only works in 
      pytorch>=2.0)
    inputBinding:
      position: 101
      prefix: --use_compile
  - id: valid_file
    type: File
    doc: VALID_FILE
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
stdout: ccsmeth_trainm.out
