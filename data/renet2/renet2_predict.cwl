cwlVersion: v1.2
class: CommandLineTool
baseCommand: predict.py
label: renet2_predict
doc: "RENET2 testing models [assemble, full-text]\n\nTool homepage: https://github.com/sujunhao/RENET2"
inputs:
  - id: add_cache_suf
    type:
      - 'null'
      - boolean
    doc: cache file suffix
    inputBinding:
      position: 101
      prefix: --add_cache_suf
  - id: batch_size
    type:
      - 'null'
      - int
    doc: input batch size for training
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: epochs
    type:
      - 'null'
      - int
    doc: number of epochs to train
    inputBinding:
      position: 101
      prefix: --epochs
  - id: file_name_ann
    type:
      - 'null'
      - string
    doc: anns file name
    inputBinding:
      position: 101
      prefix: --file_name_ann
  - id: file_name_doc
    type:
      - 'null'
      - string
    doc: document name
    inputBinding:
      position: 101
      prefix: --file_name_doc
  - id: file_name_snt
    type:
      - 'null'
      - string
    doc: sentences file name
    inputBinding:
      position: 101
      prefix: --file_name_snt
  - id: fix_snt_n
    type:
      - 'null'
      - int
    doc: number of sentence in input, recommend [for abs 32, for ft 400]
    inputBinding:
      position: 101
      prefix: --fix_snt_n
  - id: fix_token_n
    type:
      - 'null'
      - int
    doc: number of tokens
    inputBinding:
      position: 101
      prefix: --fix_token_n
  - id: gda_fn_d
    type:
      - 'null'
      - string
    doc: found gda file folder
    inputBinding:
      position: 101
      prefix: --gda_fn_d
  - id: is_filter_sub
    type:
      - 'null'
      - boolean
    doc: filter pmid in abs data
    inputBinding:
      position: 101
      prefix: --is_filter_sub
  - id: is_read_doc
    type:
      - 'null'
      - boolean
    doc: reading doc file, not renet1's abstracts file
    inputBinding:
      position: 101
      prefix: --is_read_doc
  - id: is_sensitive_mode
    type:
      - 'null'
      - boolean
    doc: using sensitive mode
    inputBinding:
      position: 101
      prefix: --is_sensitive_mode
  - id: l2_weight_decay
    type:
      - 'null'
      - float
    doc: L2 weight decay
    inputBinding:
      position: 101
      prefix: --l2_weight_decay
  - id: label_f_name
    type:
      - 'null'
      - string
    doc: modle label name
    inputBinding:
      position: 101
      prefix: --label_f_name
  - id: lr
    type:
      - 'null'
      - float
    doc: learning rate
    inputBinding:
      position: 101
      prefix: --lr
  - id: max_doc_num
    type:
      - 'null'
      - int
    doc: number of document, 0 for read all doc
    inputBinding:
      position: 101
      prefix: --max_doc_num
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: modle data dir
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: models_number
    type:
      - 'null'
      - int
    doc: number of models to train
    inputBinding:
      position: 101
      prefix: --models_number
  - id: no_cache_file
    type:
      - 'null'
      - boolean
    doc: disables using cache file for data input
    inputBinding:
      position: 101
      prefix: --no_cache_file
  - id: not_x_feature
    type:
      - 'null'
      - boolean
    doc: do not use x_feature
    inputBinding:
      position: 101
      prefix: --not_x_feature
  - id: overwrite_cache
    type:
      - 'null'
      - boolean
    doc: overwrite_cache
    inputBinding:
      position: 101
      prefix: --overwrite_cache
  - id: pretrained_model_p
    type:
      - 'null'
      - string
    doc: pretrained based models
    inputBinding:
      position: 101
      prefix: --pretrained_model_p
  - id: raw_data_dir
    type:
      - 'null'
      - Directory
    doc: input data folder
    inputBinding:
      position: 101
      prefix: --raw_data_dir
  - id: raw_input_read_batch
    type:
      - 'null'
      - int
    doc: raw data read max doc batch number
    inputBinding:
      position: 101
      prefix: --raw_input_read_batch
  - id: raw_input_read_batch_resume
    type:
      - 'null'
      - int
    doc: raw data read max doc batch number resume
    inputBinding:
      position: 101
      prefix: --raw_input_read_batch_resume
  - id: read_abs
    type:
      - 'null'
      - boolean
    doc: reading_abs_only
    inputBinding:
      position: 101
      prefix: --read_abs
  - id: read_old_file
    type:
      - 'null'
      - boolean
    doc: reading dga files
    inputBinding:
      position: 101
      prefix: --read_old_file
  - id: read_ori_token
    type:
      - 'null'
      - boolean
    doc: get raw text
    inputBinding:
      position: 101
      prefix: --read_ori_token
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_cuda
    type:
      - 'null'
      - boolean
    doc: enables CUDA training
    inputBinding:
      position: 101
      prefix: --use_cuda
  - id: using_new_tokenizer
    type:
      - 'null'
      - boolean
    doc: using new tokenizer
    inputBinding:
      position: 101
      prefix: --using_new_tokenizer
  - id: word_index_fn
    type:
      - 'null'
      - string
    doc: word index data dir
    inputBinding:
      position: 101
      prefix: --word_index_fn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
stdout: renet2_predict.out
