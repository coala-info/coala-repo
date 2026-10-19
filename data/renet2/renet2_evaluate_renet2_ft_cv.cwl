cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - renet2
  - evaluate_renet2_ft_cv
label: renet2_evaluate_renet2_ft_cv
doc: "RENET2 training models [assemble, full-text] and testing\n\nTool homepage: https://github.com/sujunhao/RENET2"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_data_dir)
        writable: true
      - $(inputs.silver_data_files)
inputs:
  - id: add_cache_suf
    type:
      - 'null'
      - boolean
    doc: cache file suffix
    inputBinding:
      position: 101
      prefix: --add_cache_suf
  - id: annotation_info_dir
    type:
      - 'null'
      - Directory
    doc: annotation data folder
    inputBinding:
      position: 101
      prefix: --annotation_info_dir
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
  - id: have_sida
    type:
      - 'null'
      - string
    doc: SiDa file prefix (reads <prefix>_01.tsv to <prefix>_10.tsv from the working directory; stage them with silver_data_files)
    inputBinding:
      position: 101
      prefix: --have_SiDa
  - id: silver_data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Silver data tables (<prefix>_01.tsv ... <prefix>_10.tsv) staged in the working directory for have_sida
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
    doc: reading doc file, not renet2's abstracts file
    inputBinding:
      position: 101
      prefix: --is_read_doc
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
  - id: models_number
    type:
      - 'null'
      - int
    doc: number of models to train
    inputBinding:
      position: 101
      prefix: --models_number
  - id: modle_dir
    type:
      - 'null'
      - Directory
    doc: modle data dir
    inputBinding:
      position: 101
      prefix: --modle_dir
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
      - File
    doc: pretrained based models (the .ckp file; the .cf file with the same stem is staged beside it)
    secondaryFiles:
      - pattern: ^.cf
        required: true
    inputBinding:
      position: 101
      prefix: --pretrained_model_p
      valueFrom: $(self.path.replace(/\.ckp$/, ''))
  - id: raw_data_dir
    type: Directory
    doc: input data folder (staged writable in the working directory, because
      the tool writes labels_n.txt, models and results into it; the path is passed
      with a trailing slash)
    inputBinding:
      position: 101
      prefix: --raw_data_dir
      valueFrom: $(self.basename)/
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
  - id: rst_file_prefix
    type:
      - 'null'
      - string
    doc: predicted GDP file
    inputBinding:
      position: 101
      prefix: --rst_file_prefix
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
      - Directory
    doc: word index data dir
    inputBinding:
      position: 101
      prefix: --word_index_fn
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: Cross-validation prediction tables, labels_n.txt and models written into the input folder
    outputBinding:
      glob:
        - $(inputs.raw_data_dir.basename)/$(inputs.rst_file_prefix || 'ft_base')_*.tsv
        - $(inputs.raw_data_dir.basename)/labels_n.txt
        - $(inputs.raw_data_dir.basename)/*.ckp
        - $(inputs.raw_data_dir.basename)/*.cf
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
stdout: renet2_evaluate_renet2_ft_cv.out
