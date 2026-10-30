cwlVersion: v1.2
class: CommandLineTool
baseCommand: VariantAnnotateFrequency
label: ngs-bits_VariantAnnotateFrequency
doc: "Annotates a variant list with variant frequencies from a BAM/CRAM file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
  - id: depth
    type:
      - 'null'
      - boolean
    doc: "Annotate an additional column containing the depth."
    inputBinding:
      position: 2
      prefix: -depth
  - id: input_file
    type: File
    doc: "Input variant list to annotate in GSvar format."
    inputBinding:
      position: 3
      prefix: -in
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: "Support long reads (> 1kb)."
    inputBinding:
      position: 4
      prefix: -long_read
  - id: mapq0
    type:
      - 'null'
      - boolean
    doc: "Annotate an additional column containing the percentage of mapq 0 reads."
    inputBinding:
      position: 5
      prefix: -mapq0
  - id: name
    type:
      - 'null'
      - string
    doc: "Column header prefix in output file."
    inputBinding:
      position: 6
      prefix: -name
  - id: output_path
    type: string
    doc: "Output variant list file in GSvar format."
    inputBinding:
      position: 7
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
      position: 8
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 9
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output variant list file in GSvar format."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
