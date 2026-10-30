cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqExtractUMI
label: ngs-bits_FastqExtractUMI
doc: "Cuts UMI bases from the beginning of reads and adds them to read headers.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in1
    type:
      - File
    doc: "Input FASTQ file 1."
    inputBinding:
      position: 1
      prefix: -in1
  - id: in2
    type:
      - File
    doc: "Input FASTQ file 2."
    inputBinding:
      position: 2
      prefix: -in2
  - id: out1
    type:
      - string
    doc: "Output filename for read 1 FASTQ."
    inputBinding:
      position: 3
      prefix: -out1
  - id: out2
    type:
      - string
    doc: "Output filename for read 2 FASTQ."
    inputBinding:
      position: 4
      prefix: -out2
  - id: cut1
    type:
      - 'null'
      - int
    doc: "Number of bases from the head of read 1 to use as UMI. Default value: 0"
    inputBinding:
      position: 5
      prefix: -cut1
  - id: cut2
    type:
      - 'null'
      - int
    doc: "Number of bases from the head of read 2 to use as UMI. Default value: 0"
    inputBinding:
      position: 6
      prefix: -cut2
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
  - id: output_fastq1
    type:
      - 'null'
      - File
    doc: "Read 1 FASTQ with the UMI in the read headers."
    outputBinding:
      glob: $(inputs.out1)
  - id: output_fastq2
    type:
      - 'null'
      - File
    doc: "Read 2 FASTQ with the UMI in the read headers."
    outputBinding:
      glob: $(inputs.out2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
