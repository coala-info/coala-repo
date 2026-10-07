cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
label: deepacstrain_train
doc: "Train a new DeePaC-strain model.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config_files)
        writable: true
arguments:
  - position: 2
    valueFrom: train
inputs:
  - id: debug_no_eager
    type:
      - 'null'
      - boolean
    doc: Disable eager mode (global option).
    inputBinding:
      position: 1
      prefix: --debug-no-eager
  - id: debug_tf
    type:
      - 'null'
      - int
    doc: 'Set tensorflow debug info verbosity level. 0 = max, 3 = min. Default: 2 (errors)
      (global option).'
    inputBinding:
      position: 1
      prefix: --debug-tf
  - id: debug_device
    type:
      - 'null'
      - boolean
    doc: Enable verbose device placement information (global option).
    inputBinding:
      position: 1
      prefix: --debug-device
  - id: force_cpu
    type:
      - 'null'
      - boolean
    doc: Use a CPU even if GPUs are available (global option).
    inputBinding:
      position: 1
      prefix: --force-cpu
  - id: tpu
    type:
      - 'null'
      - string
    doc: 'TPU name: ''colab'' for Google Colab, or name of your TPU on GCE (global option).'
    inputBinding:
      position: 1
      prefix: --tpu
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Use the sensitive model.
    inputBinding:
      position: 3
      prefix: --sensitive
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Use the rapid CNN model.
    inputBinding:
      position: 3
      prefix: --rapid
  - id: custom
    type:
      - 'null'
      - File
    doc: Use the user-supplied configuration file.
    inputBinding:
      position: 3
      prefix: --custom
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores. Default: all.'
    inputBinding:
      position: 3
      prefix: --n-cpus
  - id: gpus
    type:
      - 'null'
      - type: array
        items: string
    doc: 'GPU devices to use (comma-separated). Default: all'
    inputBinding:
      position: 3
      prefix: --gpus
  - id: train_data
    type:
      - 'null'
      - File
    doc: Path to training data.
    inputBinding:
      position: 3
      prefix: --train-data
  - id: train_labels
    type:
      - 'null'
      - File
    doc: Path to training labels.
    inputBinding:
      position: 3
      prefix: --train-labels
  - id: val_data
    type:
      - 'null'
      - File
    doc: Path to validation data.
    inputBinding:
      position: 3
      prefix: --val-data
  - id: val_labels
    type:
      - 'null'
      - File
    doc: Path to validation labels.
    inputBinding:
      position: 3
      prefix: --val-labels
  - id: run_name
    type:
      - 'null'
      - string
    doc: 'Run name (default: based on chosen config).'
    inputBinding:
      position: 3
      prefix: --run-name
  - id: config_files
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and folders named in the config file (reads, data, models), staged in the working
      directory so relative paths in the config resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log_dirs
    type:
      type: array
      items: Directory
    doc: Training log folder (LogPath in the config, 'logs' in the templates) with the per-epoch
      models <run>-eNNN.h5 and training-<run>.csv
    outputBinding:
      glob:
        - logs
        - '*-logs'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain_train.out
