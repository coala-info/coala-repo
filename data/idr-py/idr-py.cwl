cwlVersion: v1.2
class: CommandLineTool
baseCommand: idr
label: idr-py
doc: "The IDR (Irreproducible Discovery Rate) framework is a unified approach to measure
  the reproducibility of findings identified from replicate experiments and provide
  a confident set of predictions.\n\nTool homepage: https://github.com/IDR/idr-py"
inputs:
  - id: idr_threshold
    type:
      - 'null'
      - float
    doc: Only report peaks with an IDR value less than this threshold.
    inputBinding:
      position: 101
      prefix: --idr-threshold
  - id: input_file_type
    type:
      - 'null'
      - string
    doc: The format of the input files (narrowPeak, broadPeak, or bed).
    inputBinding:
      position: 101
      prefix: --input-file-type
  - id: peak_list
    type:
      - 'null'
      - File
    doc: The reference peak list. If provided, all interpretations will be made 
      relative to these peaks.
    inputBinding:
      position: 101
      prefix: --peak-list
  - id: peak_merge_method
    type:
      - 'null'
      - string
    doc: The method used to merge peaks (sum, avg, or min).
    inputBinding:
      position: 101
      prefix: --peak-merge-method
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Whether or not to plot the results.
    inputBinding:
      position: 101
      prefix: --plot
  - id: ranking_measure
    type:
      - 'null'
      - string
    doc: The measure used to rank peaks (signal.value, p.value, q.value, or 
      score).
    inputBinding:
      position: 101
      prefix: --ranking-measure
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
    doc: Report all peaks, but mark those with an IDR value less than this 
      threshold.
    inputBinding:
      position: 101
      prefix: --soft-idr-threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File name to write the IDR results to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idr-py:0.4.2--py_0
