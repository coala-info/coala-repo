cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_fastq
label: callingcardstools_split_fastq
doc: "Splits fastq files based on barcode details.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: barcode_details
    type: File
    doc: barcode filename (full path)
    inputBinding:
      position: 101
      prefix: --barcode_details
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: output_dirpath
    type:
      - 'null'
      - Directory
    doc: a path to a directory where the output files will be output. Defaults 
      to the current directory
    inputBinding:
      position: 101
      prefix: --output_dirpath
  - id: pickle_qc
    type:
      - 'null'
      - boolean
    doc: set this flag to output a pickle file which containing the 
      BarcodeQcCounter object. This is useful when splitting the fastq files 
      prior to demultiplexing
    inputBinding:
      position: 101
      prefix: --pickle_qc
  - id: read1
    type: File
    doc: Read 1 filename (full path)
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Read2 filename (full path)
    inputBinding:
      position: 101
      prefix: --read2
  - id: split_key
    type:
      - 'null'
      - string
    doc: Either a name of a key in barcode_details['components'], or just a 
      string. This will be used to create the passing output fastq filenames. 
      Defaults to 'tf' which is appropriate for yeast data
    inputBinding:
      position: 101
      prefix: --split_key
  - id: split_suffix
    type:
      - 'null'
      - string
    doc: append this after the tf name and before _R1.fq in the output fastq 
      files. Defaults to "split"
    inputBinding:
      position: 101
      prefix: --split_suffix
  - id: verbose_qc
    type:
      - 'null'
      - boolean
    doc: set this flag to output a file which contains the barcode components 
      for each read ID in the fastq files associated with its barcode components
    inputBinding:
      position: 101
      prefix: --verbose_qc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_split_fastq.out
