cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner realtime
label: deepbinner_realtime
doc: "Sort fast5 files during sequencing\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Neural network batch size
    default: 256
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: device_count
    type:
      - 'null'
      - int
    doc: TensorFlow's device_count config option
    default: 1
    inputBinding:
      position: 101
      prefix: --device_count
  - id: end_model
    type:
      - 'null'
      - string
    doc: Model trained on the ends of reads
    inputBinding:
      position: 101
      prefix: --end_model
  - id: in_dir
    type: Directory
    doc: Directory where sequencer deposits fast5 files
    inputBinding:
      position: 101
      prefix: --in_dir
  - id: inter_op_parallelism_threads
    type:
      - 'null'
      - int
    doc: TensorFlow's inter_op_parallelism_threads config option
    default: 1
    inputBinding:
      position: 101
      prefix: --inter_op_parallelism_threads
  - id: intra_op_parallelism_threads
    type:
      - 'null'
      - int
    doc: TensorFlow's intra_op_parallelism_threads config option
    default: 12
    inputBinding:
      position: 101
      prefix: --intra_op_parallelism_threads
  - id: native
    type:
      - 'null'
      - boolean
    doc: Preset for EXP-NBD103 read start and end models
    inputBinding:
      position: 101
      prefix: --native
  - id: omp_num_threads
    type:
      - 'null'
      - int
    doc: OMP_NUM_THREADS environment variable value
    default: 12
    inputBinding:
      position: 101
      prefix: --omp_num_threads
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Preset for SQK-RBK004 read start model
    inputBinding:
      position: 101
      prefix: --rapid
  - id: require_both
    type:
      - 'null'
      - boolean
    doc: 'Most stringent approach: both start and end barcodes must be present and
      agree to classify a read'
    inputBinding:
      position: 101
      prefix: --require_both
  - id: require_either
    type:
      - 'null'
      - boolean
    doc: 'Most lenient approach: a barcode call on either the start or end is sufficient
      to classify a read, as long as they do not disagree on the barcode'
    inputBinding:
      position: 101
      prefix: --require_either
  - id: require_start
    type:
      - 'null'
      - boolean
    doc: 'Moderate approach: a start barcode is required to classify a read but an
      end barcode is optional (default behaviour)'
    inputBinding:
      position: 101
      prefix: --require_start
  - id: scan_size
    type:
      - 'null'
      - int
    doc: This much of a read's start/end signal will examined for barcode 
      signals
    default: 6144
    inputBinding:
      position: 101
      prefix: --scan_size
  - id: score_diff
    type:
      - 'null'
      - float
    doc: For a read to be classified, there must be this much difference between
      the best and second-best barcode scores
    default: 0.5
    inputBinding:
      position: 101
      prefix: --score_diff
  - id: start_model
    type:
      - 'null'
      - string
    doc: Model trained on the starts of reads
    inputBinding:
      position: 101
      prefix: --start_model
outputs:
  - id: out_dir
    type: Directory
    doc: Directory to output binned fast5 files
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
