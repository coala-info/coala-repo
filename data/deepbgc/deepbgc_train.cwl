cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbgc train
label: deepbgc_train
doc: "Train a BGC detector/classifier on a set of BGC samples.\n\nTool homepage: https://github.com/Merck/DeepBGC"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Training sequences (Pfam TSV) file paths
    inputBinding:
      position: 1
  - id: classes
    type:
      - 'null'
      - File
    doc: Class TSV file path - train a sequence classifier using provided 
      classes (binary columns), indexed by sequence_id column
    inputBinding:
      position: 102
      prefix: --classes
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: Variables in model JSON file to replace (e.g. --config PFAM2VEC 
      path/to/pfam2vec.csv)
    inputBinding:
      position: 102
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: log
    type:
      - 'null'
      - File
    doc: Progress log output path (e.g. TensorBoard)
    inputBinding:
      position: 102
      prefix: --log
  - id: model
    type: File
    doc: Path to JSON model config file
    inputBinding:
      position: 102
      prefix: --model
  - id: target
    type:
      - 'null'
      - string
    doc: Target column to predict in sequence prediction
    inputBinding:
      position: 102
      prefix: --target
  - id: validation
    type:
      - 'null'
      - type: array
        items: File
    doc: Validation sequence file path. Repeat to specify multiple files
    inputBinding:
      position: 102
      prefix: --validation
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0=none, 1=progress bar, 2=once per epoch (default: 2)'
    default: 2
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output trained model file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
