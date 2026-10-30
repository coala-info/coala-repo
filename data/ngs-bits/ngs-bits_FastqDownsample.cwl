cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqDownsample
label: ngs-bits_FastqDownsample
doc: "Downsamples paired-end FASTQ files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in1
    type: File
    doc: "Forward input gzipped FASTQ file(s)."
    inputBinding:
      position: 101
      prefix: -in1
  - id: in2
    type: File
    doc: "Reverse input gzipped FASTQ file(s)."
    inputBinding:
      position: 101
      prefix: -in2
  - id: percentage
    type: float
    doc: "Percentage of reads to keep."
    inputBinding:
      position: 101
      prefix: -percentage
  - id: out1_path
    type: string
    doc: "Forward output gzipped FASTQ file."
    inputBinding:
      position: 102
      prefix: -out1
  - id: out2_path
    type: string
    doc: "Reverse output gzipped FASTQ file."
    inputBinding:
      position: 102
      prefix: -out2
  - id: test
    type:
      - 'null'
      - boolean
    doc: "Test mode: fix random number generator seed and write kept read names to STDOUT. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -test
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
    doc: "Forward output gzipped FASTQ file."
    outputBinding:
      glob: $(inputs.out1_path)
  - id: out2
    type: File
    doc: "Reverse output gzipped FASTQ file."
    outputBinding:
      glob: $(inputs.out2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
