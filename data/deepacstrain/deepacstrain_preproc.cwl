cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
label: deepacstrain_preproc
doc: "Convert fasta files to numpy arrays for training (paths come from the preprocessing\
  \ config file).\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config_files)
        writable: true
arguments:
  - position: 2
    valueFrom: preproc
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
  - id: config
    type: File
    doc: Preprocessing config file.
    inputBinding:
      position: 10
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
  - id: arrays
    type:
      type: array
      items: File
    doc: Output data and label arrays (or TFRecord files) named in the config
    outputBinding:
      glob:
        - '*.npy'
        - '*.npy.gz'
        - '*.tfrec'
        - '*/*.npy'
        - '*/*.npy.gz'
        - '*/*.tfrec'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain_preproc.out
