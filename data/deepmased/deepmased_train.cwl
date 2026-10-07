cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeepMAsED
  - train
label: deepmased_train
doc: "Train model\n\nTool homepage: https://github.com/leylabmpi/DeepMAsED"
inputs:
  - id: feature_file_table
    type: File
    doc: Table listing feature table files (columns rep, assembler, feature_file)
    inputBinding:
      position: 2
  - id: technology
    type:
      - 'null'
      - string
    doc: 'Assembler name in the data_path. "all-asmbl" will use all assemblers (default: all-asmbl)'
    inputBinding:
      position: 1
      prefix: --technology
  - id: save_path
    type:
      - 'null'
      - string
    doc: 'Where to save training weights and logs (default: model)'
    default: model
    inputBinding:
      position: 1
      prefix: --save-path
  - id: save_name
    type:
      - 'null'
      - string
    doc: 'Prefix for name in the save-path (default: deepmased)'
    inputBinding:
      position: 1
      prefix: --save-name
  - id: filters
    type:
      - 'null'
      - int
    doc: 'N of filters for first conv layer. Then x2 (default: 8)'
    inputBinding:
      position: 1
      prefix: --filters
  - id: n_hid
    type:
      - 'null'
      - int
    doc: 'N of units in fully connected layers (default: 50)'
    inputBinding:
      position: 1
      prefix: --n-hid
  - id: n_conv
    type:
      - 'null'
      - int
    doc: 'N of conv layers (default: 5)'
    inputBinding:
      position: 1
      prefix: --n-conv
  - id: n_fc
    type:
      - 'null'
      - int
    doc: 'N of fully connected layers (default: 3)'
    inputBinding:
      position: 1
      prefix: --n-fc
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: 'N of training epochs (default: 10)'
    inputBinding:
      position: 1
      prefix: --n-epochs
  - id: max_len
    type:
      - 'null'
      - int
    doc: 'Max contig len, fixed input for CNN (default: 10000)'
    inputBinding:
      position: 1
      prefix: --max-len
  - id: dropout
    type:
      - 'null'
      - float
    doc: 'Rate of dropout (default: 0.5)'
    inputBinding:
      position: 1
      prefix: --dropout
  - id: pool_window
    type:
      - 'null'
      - int
    doc: 'Window size for average pooling (default: 50)'
    inputBinding:
      position: 1
      prefix: --pool-window
  - id: n_folds
    type:
      - 'null'
      - int
    doc: 'How many folds for CV. Use "-1" to skip & pool all data for training (default: -1)'
    inputBinding:
      position: 1
      prefix: --n-folds
  - id: lr_init
    type:
      - 'null'
      - float
    doc: 'Size of test set (default: 0.001)'
    inputBinding:
      position: 1
      prefix: --lr-init
  - id: norm_raw
    type:
      - 'null'
      - int
    doc: 'Whether to normalize the four one-hot feature of raw (default: 0)'
    inputBinding:
      position: 1
      prefix: --norm-raw
  - id: pickle_only
    type:
      - 'null'
      - boolean
    doc: 'Only pickle files (default: False)'
    inputBinding:
      position: 1
      prefix: --pickle-only
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: 'Force re-creation of pickle files (default: False)'
    inputBinding:
      position: 1
      prefix: --force-overwrite
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Seed used for numpy.random (default: 12)'
    inputBinding:
      position: 1
      prefix: --seed
  - id: n_procs
    type:
      - 'null'
      - int
    doc: 'Number of parallel processes (default: 1)'
    inputBinding:
      position: 1
      prefix: --n-procs
  - id: data_files
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and folders named in the input table (feature tables, or BAM files with their
      .bai index and FASTA files; the image has no samtools to index BAM files), staged writable
      in the working directory so the relative paths in the table resolve and the tool can
      write pickles or indexes beside them
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Model weights (<save-name>_<technology>_model.h5), mean/std pickle, CV scores and
      logs
    outputBinding:
      glob: $(inputs.save_path)
  - id: pickled_features
    type:
      type: array
      items: File
    doc: Pickled feature tables written beside the staged feature files
    outputBinding:
      glob:
        - '*.pkl'
        - '*/*.pkl'
        - '*/*/*.pkl'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.data_files ? inputs.data_files : [])'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased_train.out
