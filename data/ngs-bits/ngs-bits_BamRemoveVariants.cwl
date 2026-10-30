cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamRemoveVariants
label: ngs-bits_BamRemoveVariants
doc: "Removes reads which contain the provided variants\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
  - id: output_file_path
    type: string
    doc: "Output BAM/CRAM file."
    inputBinding:
      position: 102
      prefix: -out
  - id: vcf
    type: File
    doc: "Input indexed VCF.GZ file."
    secondaryFiles:
      - pattern: .tbi
        required: true
    inputBinding:
      position: 101
      prefix: -vcf
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
  - id: mask
    type:
      - 'null'
      - boolean
    doc: "Replace variant bases with reference instead of removing the read (SNV only) Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -mask
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: "Input file is from single-end sequencing (e.g. lrGS). Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -single_end
  - id: keep_indels
    type:
      - 'null'
      - boolean
    doc: "Do not remove InDels in mask mode. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -keep_indels
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
