cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - yeast_combine_qc
label: callingcardstools_yeast_combine_qc
doc: "Combine BarcodeQcCounter objects which may result from splitting the fastq files prior to demultiplexing.\n\
  \nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: a list of paths to BarcodeQcCounter object pickle files
    inputBinding:
      position: 103
      prefix: --input
  - id: barcode_details
    type: File
    doc: barcode filename (full path)
    inputBinding:
      position: 103
      prefix: --barcode_details
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set the logging level. Options: critical, error, warning, info, debug'
    inputBinding:
      position: 103
      prefix: --log_level
  - id: output_dirpath
    type:
      - 'null'
      - string
    doc: a path to a directory where the output files will be output. Defaults 
      to the current directory
    inputBinding:
      position: 103
      prefix: --output_dirpath
  - id: prefix
    type:
      - 'null'
      - string
    doc: filename prefix for output files. Defaults to barcode_qc
    inputBinding:
      position: 103
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dirpath_dir
    type:
      - 'null'
      - Directory
    doc: a path to a directory where the output files will be output. Defaults 
      to the current directory
    outputBinding:
      glob: $(inputs.output_dirpath)
  - id: barcode_qc
    type:
      type: array
      items: File
    doc: Combined barcode QC summary csv files (<prefix>_r1_primer_summary.csv,
      <prefix>_r2_transposon_summary.csv)
    outputBinding:
      glob: '$(inputs.output_dirpath ? inputs.output_dirpath : ".")/$(inputs.prefix
        ? inputs.prefix : "barcode_qc")*.csv'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.output_dirpath ? [{"class": "Directory", "basename": inputs.output_dirpath,
      "listing": [], "writable": true}] : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_yeast_combine_qc.out
