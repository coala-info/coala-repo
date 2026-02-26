cwlVersion: v1.2
class: CommandLineTool
baseCommand: mammals_combine_qc
label: callingcardstools_mammals_combine_qc
doc: "Combines QC data from multiple Qbed and BarcodeQcCounter objects.\n\nTool homepage:
  https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: qbed_list
    type:
      type: array
      items: File
    doc: A list of pickled Qbed objects
    inputBinding:
      position: 1
  - id: barcodeQcCounter_list
    type:
      type: array
      items: File
    doc: A list of pickled BarcodeQcCounter objects
    inputBinding:
      position: 2
  - id: filename
    type:
      - 'null'
      - string
    doc: Base filename (no extension) for output files.
    inputBinding:
      position: 103
      prefix: --filename
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (critical, error, warning, info, debug)
    inputBinding:
      position: 103
      prefix: --log_level
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: Set this flag to save the qbed and qc data as pickle files. This is 
      useful when processing split files in parallel and then combining later. 
      Defaults to False, which saves as qbed/tsv
    default: false
    inputBinding:
      position: 103
      prefix: --pickle
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to the base filename.
    inputBinding:
      position: 103
      prefix: --suffix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_mammals_combine_qc.out
