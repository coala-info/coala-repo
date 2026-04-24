cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner classify
label: deepbinner_classify
doc: "Classify fast5 reads\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: input
    type: File
    doc: 'One of the following: a single fast5 file, a directory of fast5 files (will
      be searched recursively) or a tab-delimited file of training data'
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Neural network batch size
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: device_count
    type:
      - 'null'
      - int
    doc: TensorFlow's device_count config option
    inputBinding:
      position: 102
      prefix: --device_count
  - id: end_model
    type:
      - 'null'
      - File
    doc: Model trained on the ends of reads
    inputBinding:
      position: 102
      prefix: --end_model
  - id: inter_op_parallelism_threads
    type:
      - 'null'
      - int
    doc: TensorFlow's inter_op_parallelism_threads config option
    inputBinding:
      position: 102
      prefix: --inter_op_parallelism_threads
  - id: intra_op_parallelism_threads
    type:
      - 'null'
      - int
    doc: TensorFlow's intra_op_parallelism_threads config option
    inputBinding:
      position: 102
      prefix: --intra_op_parallelism_threads
  - id: native
    type:
      - 'null'
      - boolean
    doc: Preset for EXP-NBD103 read start and end models
    inputBinding:
      position: 102
      prefix: --native
  - id: omp_num_threads
    type:
      - 'null'
      - int
    doc: OMP_NUM_THREADS environment variable value
    inputBinding:
      position: 102
      prefix: --omp_num_threads
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Preset for SQK-RBK004 read start model
    inputBinding:
      position: 102
      prefix: --rapid
  - id: require_both
    type:
      - 'null'
      - boolean
    doc: 'Most stringent approach: both start and end barcodes must be present and
      agree to classify a read'
    inputBinding:
      position: 102
      prefix: --require_both
  - id: require_either
    type:
      - 'null'
      - boolean
    doc: 'Most lenient approach: a barcode call on either the start or end is sufficient
      to classify a read, as long as they do not disagree on the barcode'
    inputBinding:
      position: 102
      prefix: --require_either
  - id: require_start
    type:
      - 'null'
      - boolean
    doc: 'Moderate approach: a start barcode is required to classify a read but an
      end barcode is optional (default behaviour)'
    inputBinding:
      position: 102
      prefix: --require_start
  - id: scan_size
    type:
      - 'null'
      - int
    doc: This much of a read's start/end signal will examined for barcode 
      signals
    inputBinding:
      position: 102
      prefix: --scan_size
  - id: score_diff
    type:
      - 'null'
      - float
    doc: For a read to be classified, there must be this much difference between
      the best and second-best barcode scores
    inputBinding:
      position: 102
      prefix: --score_diff
  - id: start_model
    type:
      - 'null'
      - File
    doc: Model trained on the starts of reads
    inputBinding:
      position: 102
      prefix: --start_model
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Include the output probabilities for all barcodes in the results (default:
      just show the final barcode call)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
stdout: deepbinner_classify.out
