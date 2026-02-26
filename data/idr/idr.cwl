cwlVersion: v1.2
class: CommandLineTool
baseCommand: idr
label: idr
doc: "The IDR (Irreproducible Discovery Rate) framework is a unified approach to measure
  the reproducibility of findings identified from replicate experiments and provide
  confident biological predictions.\n\nTool homepage: https://github.com/kundajelab/idr"
inputs:
  - id: idr_threshold
    type:
      - 'null'
      - float
    doc: Only report peaks with an IDR less than this value.
    inputBinding:
      position: 101
      prefix: --idr-threshold
  - id: max_peaks
    type:
      - 'null'
      - int
    doc: The maximum number of peaks to consider.
    inputBinding:
      position: 101
      prefix: --max-peaks
  - id: output_file_type
    type:
      - 'null'
      - string
    doc: 'Format of the output file: narrowPeak, broadPeak, bed.'
    default: narrowPeak
    inputBinding:
      position: 101
      prefix: --output-file-type
  - id: peak_list
    type:
      - 'null'
      - File
    doc: The reference peak list. If provided, all other peak lists will be 
      compared to this one.
    inputBinding:
      position: 101
      prefix: --peak-list
  - id: peak_merge_method
    type:
      - 'null'
      - string
    doc: 'Which method to use for merging peaks: sum, avg, min, max.'
    default: sum
    inputBinding:
      position: 101
      prefix: --peak-merge-method
  - id: peak_value_control
    type:
      - 'null'
      - string
    doc: 'The column to use for ranking peaks: p.value, q.value, signal.value, score.'
    default: p.value
    inputBinding:
      position: 101
      prefix: --peak-value-control
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Whether or not to generate a plot of the results.
    inputBinding:
      position: 101
      prefix: --plot
  - id: random_seed
    type:
      - 'null'
      - int
    doc: The random seed to use.
    default: 0
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: rank
    type:
      - 'null'
      - string
    doc: Which column to use for ranking peaks if peak-value-control is not 
      used.
    inputBinding:
      position: 101
      prefix: --rank
  - id: samples
    type:
      type: array
      items: File
    doc: Files containing peaks to be compared.
    inputBinding:
      position: 101
      prefix: --samples
  - id: soft_idr_threshold
    type:
      - 'null'
      - float
    doc: Report peaks with an IDR less than this value, but do not use them for 
      the final IDR calculation.
    inputBinding:
      position: 101
      prefix: --soft-idr-threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the IDR results to.
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_output_file
    type:
      - 'null'
      - File
    doc: File to write the log to.
    outputBinding:
      glob: $(inputs.log_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idr:2.0.4.2--py39h031d066_12
