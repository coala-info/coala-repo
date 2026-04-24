cwlVersion: v1.2
class: CommandLineTool
baseCommand: parm train
label: parm_train
doc: "Promoter Activity Regulatory Model\n\nTool homepage: https://github.com/vansteensellab/PARM"
inputs:
  - id: adaptor
    type:
      - 'null'
      - type: array
        items: string
    doc: "If not false, give adaptor in 5 and 3 prima to use\n                   \
      \       as padding. e.g. -adaptor CAGTGAT ACGACTG"
      - CAGTGAT
      - ACGACTG
    inputBinding:
      position: 101
      prefix: --adaptor
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of samples in ech batch to train the data to
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: betas
    type:
      - 'null'
      - type: array
        items: float
    doc: L1 and L2 regularization terms respectively.
      - 0.005
      - 0.005
    inputBinding:
      position: 101
      prefix: --betas
  - id: cell_type
    type: string
    doc: "The name of the cell type that you want to create a\n                  \
      \        model to. This should be the same name as in the\n                \
      \          input h5 files"
    inputBinding:
      position: 101
      prefix: --cell_type
  - id: check_cuda
    type:
      - 'null'
      - boolean
    doc: Check if CUDA is available and exit
    inputBinding:
      position: 101
      prefix: --check_cuda
  - id: cosine_scheduler
    type:
      - 'null'
      - boolean
    doc: "If True, implement a cosine schedueler for learning\n                  \
      \        rate. Otherwise, learning rate will be constant\n                 \
      \         after warmup."
    inputBinding:
      position: 101
      prefix: --cosine_scheduler
  - id: filter_size
    type:
      - 'null'
      - int
    doc: Number of filters in convolution layers
    inputBinding:
      position: 101
      prefix: --filter_size
  - id: initial_weights
    type:
      - 'null'
      - File
    doc: "Path to initial weights file. If None, random\n                        \
      \  initialization is used."
    inputBinding:
      position: 101
      prefix: --initial_weights
  - id: input
    type:
      type: array
      items: File
    doc: "Path to input files. This should be a pre-processed\n                  \
      \        MPRA data file. saved as a .h5 file. If you have\n                \
      \          multiple files, you can pass them as a space-\n                 \
      \         separated list."
    inputBinding:
      position: 101
      prefix: --input
  - id: l_max
    type:
      - 'null'
      - int
    doc: "Maximum length of fragments. Necessary if we want to\n                 \
      \         downsample."
    inputBinding:
      position: 101
      prefix: --L_max
  - id: lr
    type:
      - 'null'
      - float
    doc: Learning rate
    inputBinding:
      position: 101
      prefix: --lr
  - id: n_blocks
    type:
      - 'null'
      - int
    doc: Number of convolution blocks.
    inputBinding:
      position: 101
      prefix: --n_blocks
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: Number of epochs to train the data to
    inputBinding:
      position: 101
      prefix: --n_epochs
  - id: n_workers
    type:
      - 'null'
      - int
    doc: How many subprocesses to use for data loading
    inputBinding:
      position: 101
      prefix: --n_workers
  - id: validation
    type:
      type: array
      items: File
    doc: "Path to validation files. This should be a pre-\n                      \
      \    processed MPRA data file. saved as a .h5 file. If\n                   \
      \       you have multiple files"
    inputBinding:
      position: 101
      prefix: --validation
  - id: weight_decay
    type:
      - 'null'
      - float
    doc: Weight decay
    inputBinding:
      position: 101
      prefix: --weight_decay
outputs:
  - id: output
    type: Directory
    doc: Path to the directory to store all the output files.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
