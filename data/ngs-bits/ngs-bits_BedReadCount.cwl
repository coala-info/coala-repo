cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedReadCount
label: ngs-bits_BedReadCount
doc: "Annotates the regions in a BED file with the read count from a BAM/CRAM file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam
    type: File
    doc: "Input BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -bam
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality. Default value: '1'"
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BED file (note that overlapping regions will be merged before processing). If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
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
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
