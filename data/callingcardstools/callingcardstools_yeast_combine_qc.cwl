cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_fastq
label: callingcardstools_yeast_combine_qc
doc: "Splits BarcodeQcCounter objects into separate files based on barcode details.\n\
  \nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: a list of paths to BarcodeQcCounter object pickle files
    inputBinding:
      position: 1
  - id: barcode_details
    type: string
    doc: barcode filename (full path)
    inputBinding:
      position: 2
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set the logging level. Options: critical, error, warning, info, debug'
    default: info
    inputBinding:
      position: 103
      prefix: --log_level
  - id: output_dirpath
    type:
      - 'null'
      - Directory
    doc: a path to a directory where the output files will be output. Defaults 
      to the current directory
    default: .
    inputBinding:
      position: 103
      prefix: --output_dirpath
  - id: prefix
    type:
      - 'null'
      - string
    doc: filename prefix for output files. Defaults to barcode_qc
    default: barcode_qc
    inputBinding:
      position: 103
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_yeast_combine_qc.out
