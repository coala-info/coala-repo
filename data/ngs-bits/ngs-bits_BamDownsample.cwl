cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamDownsample
label: ngs-bits_BamDownsample
doc: "Downsamples a BAM file to the given percentage of reads.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -in
  - id: percentage
    type: float
    doc: "Percentage of reads to keep."
    inputBinding:
      position: 101
      prefix: -percentage
  - id: output_file_path
    type: string
    doc: "Output BAM/CRAM file."
    inputBinding:
      position: 102
      prefix: -out
  - id: test
    type:
      - 'null'
      - boolean
    doc: "Test mode: fix random number generator seed and write kept read names to STDOUT. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -test
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome for CRAM support (mandatory if CRAM is used)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: -ref
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output BAM/CRAM file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
