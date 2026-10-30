cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqExtractBarcode
label: ngs-bits_FastqExtractBarcode
doc: "Cuts bases from the beginning of reads and stores them in an additional fastq.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input fastq file 1."
    inputBinding:
      position: 1
      prefix: -in
  - id: out_main
    type:
      - string
    doc: "Output filename for main fastq."
    inputBinding:
      position: 2
      prefix: -out_main
  - id: out_index
    type:
      - 'null'
      - string
    doc: "Output filename for index fastq. Default value: 'index.fastq.gz'"
    default: index.fastq.gz
    inputBinding:
      position: 3
      prefix: -out_index
  - id: cut
    type:
      - 'null'
      - int
    doc: "Number of bases from the beginning of reads to use as barcodes. Default value: 0"
    inputBinding:
      position: 4
      prefix: -cut
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output FASTQ compression level from 1 (fastest) to 9 (best compression). Default value: 1"
    inputBinding:
      position: 10
      prefix: -compression_level
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: main_fastq
    type:
      - 'null'
      - File
    doc: "Main FASTQ with the barcode bases removed."
    outputBinding:
      glob: $(inputs.out_main)
  - id: index_fastq
    type:
      - 'null'
      - File
    doc: "Index FASTQ with the barcode bases."
    outputBinding:
      glob: $(inputs.out_index)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
