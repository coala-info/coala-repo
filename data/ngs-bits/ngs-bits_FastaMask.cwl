cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastaMask
label: ngs-bits_FastaMask
doc: "Mask regions in a FASTA file with N bases.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input FASTA file."
    inputBinding:
      position: 101
      prefix: -in
  - id: reg
    type: File
    doc: "Input BED file with regions to mask."
    inputBinding:
      position: 101
      prefix: -reg
  - id: output_file_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: -out
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
    doc: "Output file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
