cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqAddBarcode
label: ngs-bits_FastqAddBarcode
doc: "Adds barcodes from separate FASTQ file to read headers.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in1
    type:
      type: array
      items: File
    doc: "Input FASTQ file 1."
    inputBinding:
      position: 101
      prefix: -in1
  - id: in2
    type:
      type: array
      items: File
    doc: "Input FASTQ file 2."
    inputBinding:
      position: 101
      prefix: -in2
  - id: in_barcode
    type:
      type: array
      items: File
    doc: "Input barcode file."
    inputBinding:
      position: 101
      prefix: -in_barcode
  - id: out1_path
    type: string
    doc: "Output filename for read 1 FASTQ."
    inputBinding:
      position: 102
      prefix: -out1
  - id: out2_path
    type: string
    doc: "Output filename for read 2 FASTQ."
    inputBinding:
      position: 102
      prefix: -out2
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output FASTQ compression level from 1 (fastest) to 9 (best compression). Default value: '1'"
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: out1
    type: File
    doc: "Output filename for read 1 FASTQ."
    outputBinding:
      glob: $(inputs.out1_path)
  - id: out2
    type: File
    doc: "Output filename for read 2 FASTQ."
    outputBinding:
      glob: $(inputs.out2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
