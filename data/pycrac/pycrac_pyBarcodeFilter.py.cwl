cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyBarcodeFilter.py
label: pycrac_pyBarcodeFilter.py
doc: "Filters FASTQ/FASTA files based on barcodes.\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs:
  - id: barcode_list
    type: File
    doc: name of tab-delimited file containing barcodes and barcode names
    inputBinding:
      position: 101
      prefix: --barcode_list
  - id: file_type
    type:
      - 'null'
      - string
    doc: type of file, uncompressed (fasta or fastq) or compressed (fasta.gz or 
      fastq.gz, gzip/gunzip compressed). Default is fastq
    inputBinding:
      position: 101
      prefix: --file_type
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: use this option to compress all the output files using gunzip or gzip 
      (compression level 9). Note that this can significantly slow down the 
      program
    inputBinding:
      position: 101
      prefix: --gzip
  - id: index
    type:
      - 'null'
      - boolean
    doc: use this option if you want to split the data using the Illumina 
      indexing barcode information
    inputBinding:
      position: 101
      prefix: --index
  - id: input_file
    type: File
    doc: name of the FASTQ or FASTA input file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: keep_barcode
    type:
      - 'null'
      - boolean
    doc: in case you do not want to remove the in read barcode from the 
      sequences. Useful when uploading data to repositories.
    inputBinding:
      position: 101
      prefix: --keep_barcode
  - id: mismatches
    type:
      - 'null'
      - int
    doc: to set the number of allowed mismatches in a barcode. Only one mismatch
      is allowed. Default = 0
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: reverse_input_file
    type:
      - 'null'
      - File
    doc: name of the paired (or reverse) FASTQ or FASTA input file
    inputBinding:
      position: 101
      prefix: --reverse_input_file
  - id: search
    type:
      - 'null'
      - string
    doc: use this flag if barcode sequences need to be removed from the forward 
      or the reverse reads. The tool assumes. Default=forward
    inputBinding:
      position: 101
      prefix: --search
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: prints all the status messages to a file rather than the standard 
      output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
stdout: pycrac_pyBarcodeFilter.py.out
