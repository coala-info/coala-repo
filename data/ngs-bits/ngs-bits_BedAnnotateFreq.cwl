cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateFreq
label: ngs-bits_BedAnnotateFreq
doc: "Extracts base counts and depth in the given regions from a BAM/CRAM files.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: "Input BAM/CRAM file(s)."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -bam
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BED file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output TSV file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
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
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality. Default value: '1'"
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: "Minimum base quality. Default value: '25'"
    inputBinding:
      position: 101
      prefix: -min_baseq
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: "Support long reads (> 1kb). Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -long_read
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
    doc: "Output TSV file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
