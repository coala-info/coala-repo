cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SemiBin2
  - train_self
label: semibin_train_self
doc: 'Train the model with self-supervised learning.


  Tool homepage: https://github.com/BigDataBiology/SemiBin'
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Batch size used in the training process (Default: 2048).'
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: train_from_many
    type:
      - 'null'
      - boolean
    doc: 'Train the model with several samples. You must provide data, data_split,
      cannot, and fasta files for corresponding samples in the same order. Note: You
      can only use `--train-from-many` mode when performing single-sample binning.
      Training from many samples with multi-sample binning is not supported.'
    inputBinding:
      position: 1
      prefix: --train-from-many
  - id: no_train_from_many
    type:
      - 'null'
      - boolean
    doc: 'Train the model with several samples. You must provide data, data_split,
      cannot, and fasta files for corresponding samples in the same order. Note: You
      can only use `--train-from-many` mode when performing single-sample binning.
      Training from many samples with multi-sample binning is not supported.'
    inputBinding:
      position: 1
      prefix: --no-train-from-many
  - id: epochs
    type:
      - 'null'
      - int
    doc: 'Number of epochs used in the training process (Default: 15).'
    inputBinding:
      position: 1
      prefix: --epochs
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: option to set temporary directory
    inputBinding:
      position: 1
      prefix: --tmpdir
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of CPUs used (pass the value 0 to use all CPUs, default: 0)'
    inputBinding:
      position: 1
      prefix: --processes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output
    inputBinding:
      position: 1
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed. Set it to a fixed value to reproduce results across runs. The
      default is that the seed is set by the system and .
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: engine
    type:
      - 'null'
      - string
    doc: device used to train the model (auto/gpu/cpu, auto means if SemiBin detects
      the gpu, SemiBin will use GPU)
    inputBinding:
      position: 1
      prefix: --engine
  - id: data
    type:
      type: array
      items: File
    doc: Path to the input data.csv file.
    inputBinding:
      position: 1
      prefix: --data
  - id: data_split
    type:
      type: array
      items: File
    doc: Path to the input data_split.csv file.
    inputBinding:
      position: 1
      prefix: --data-split
  - id: output
    type: string
    doc: Output directory (will be created if non-existent)
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
