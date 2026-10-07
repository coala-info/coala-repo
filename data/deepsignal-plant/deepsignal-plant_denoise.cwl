cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsignal_plant
  - denoise
label: deepsignal-plant_denoise
doc: "denoise training samples by deep-learning, filter false positive samples (and false negative samples).\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.train_file)
        writable: true
inputs:
  - id: train_file
    type: File
    doc: "file containing (combined positive and negative) samples for training. better been balanced in kmer level."
    inputBinding:
      position: 101
      prefix: --train_file
      valueFrom: $(self.basename)
  - id: is_filter_fn
    type:
      - 'null'
      - string
    doc: "is filter false negative samples, , 'yes' or 'no', default no"
    inputBinding:
      position: 101
      prefix: --is_filter_fn
  - id: model_type
    type:
      - 'null'
      - string
    doc: "type of model to use, 'both_bilstm', 'seq_bilstm' or 'signal_bilstm', 'both_bilstm' means to use both seq and signal bilstm, default: signal_bilstm"
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
  - id: pos_weight
    type:
      - 'null'
      - float
    doc: "positive sample weight"
    inputBinding:
      position: 101
      prefix: --pos_weight
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
  - id: epoch_num
    type:
      - 'null'
      - int
    doc: "epoch number"
    inputBinding:
      position: 101
      prefix: --epoch_num
  - id: step_interval
    type:
      - 'null'
      - int
    doc: "step interval"
    inputBinding:
      position: 101
      prefix: --step_interval
  - id: iterations
    type:
      - 'null'
      - int
    doc: "number of iterations"
    inputBinding:
      position: 101
      prefix: --iterations
  - id: rounds
    type:
      - 'null'
      - int
    doc: "number of rounds"
    inputBinding:
      position: 101
      prefix: --rounds
  - id: score_cf
    type:
      - 'null'
      - float
    doc: "score cutoff to keep high quality (which prob>=score_cf) positive samples. (0, 0.5], default 0.5"
    inputBinding:
      position: 101
      prefix: --score_cf
  - id: kept_ratio
    type:
      - 'null'
      - float
    doc: "kept ratio of samples, to end denoise process. default 0.99"
    inputBinding:
      position: 101
      prefix: --kept_ratio
  - id: fst_iter_prob
    type:
      - 'null'
      - boolean
    doc: "if output probs of samples after 1st iteration"
    inputBinding:
      position: 101
      prefix: --fst_iter_prob
outputs:
  - id: denoised_samples
    type: File[]
    doc: denoised training samples written beside the input file
    outputBinding:
      glob: '*denoise*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
