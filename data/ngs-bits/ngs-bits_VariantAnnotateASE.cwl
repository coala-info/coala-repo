cwlVersion: v1.2
class: CommandLineTool
baseCommand: VariantAnnotateASE
label: ngs-bits_VariantAnnotateASE
doc: "Annotates a variant list with variant frequencies from a RNA BAM/CRAM file. Used to check for allele-specific expression.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam
    type: File
    doc: "Input BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
      prefix: -bam
  - id: input_file
    type: File
    doc: "Input variant list to annotate in GSvar format."
    inputBinding:
      position: 2
      prefix: -in
  - id: output_path
    type: string
    doc: "Output variant list file name (VCF or GSvar)."
    inputBinding:
      position: 3
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 4
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 5
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output variant list file name (VCF or GSvar)."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
