cwlVersion: v1.2
class: CommandLineTool
baseCommand: minisplice predict
label: minisplice_predict
doc: "Predict splice sites\n\nTool homepage: https://github.com/lh3/minisplice"
inputs:
  - id: input_kan
    type: File
    doc: Input kan file
    inputBinding:
      position: 1
  - id: input_fastx_or_train
    type: string
    doc: Input fastx file or training data file
    inputBinding:
      position: 2
  - id: acceptor_only
    type:
      - 'null'
      - boolean
    doc: acceptor only
    inputBinding:
      position: 103
      prefix: -a
  - id: annotated_splice_sites_bed
    type:
      - 'null'
      - File
    doc: annotated splice sites in BED12
    default: '[]'
    inputBinding:
      position: 103
      prefix: -b
  - id: calibration_data
    type:
      - 'null'
      - File
    doc: calibration data
    default: '[]'
    inputBinding:
      position: 103
      prefix: -c
  - id: donor_only
    type:
      - 'null'
      - boolean
    doc: donor only
    inputBinding:
      position: 103
      prefix: -d
  - id: input_formatted_as_training_data
    type:
      - 'null'
      - boolean
    doc: input formatted as training data
    inputBinding:
      position: 103
      prefix: -r
  - id: max_score
    type:
      - 'null'
      - int
    doc: max score
    default: 13
    inputBinding:
      position: 103
      prefix: -h
  - id: min_score
    type:
      - 'null'
      - int
    doc: min score
    default: -6
    inputBinding:
      position: 103
      prefix: -l
  - id: minibatch_size
    type:
      - 'null'
      - int
    doc: minibatch size
    default: 128
    inputBinding:
      position: 103
      prefix: -m
  - id: print_calibration_data
    type:
      - 'null'
      - boolean
    doc: print calibration data
    inputBinding:
      position: 103
      prefix: -E
  - id: print_last_max1d_layer_values
    type:
      - 'null'
      - boolean
    doc: print values at the last max1d layer
    inputBinding:
      position: 103
      prefix: -p
  - id: score_bin_size
    type:
      - 'null'
      - float
    doc: score bin size
    default: 0.02
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
stdout: minisplice_predict.out
