cwlVersion: v1.2
class: CommandLineTool
baseCommand: CfDnaQC
label: ngs-bits_CfDnaQC
doc: "Calculates QC metrics for cfDNA samples.\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
  - id: cfdna_panel
    type: File
    doc: "Input BED file containing the (personalized) cfDNA panel."
    inputBinding:
      position: 101
      prefix: -cfdna_panel
  - id: output_file_path
    type: string
    doc: "Output qcML file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: tumor_bam
    type:
      - 'null'
      - File
    doc: "Input tumor BAM/CRAM file for sample similarity."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -tumor_bam
  - id: related_bams
    type:
      - 'null'
      - type: array
        items: File
    doc: "BAM files of related cfDNA samples to compute sample similarity."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: -related_bams
  - id: error_rates
    type:
      - 'null'
      - File
    doc: "Input TSV containing umiVar error rates."
    inputBinding:
      position: 101
      prefix: -error_rates
  - id: build
    type:
      - 'null'
      - type: enum
        symbols:
          - hg19
          - hg38
    doc: "Genome build used to generate the input. Default value: 'hg38' Valid: hg19, hg38"
    inputBinding:
      position: 101
      prefix: -build
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
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
    doc: "Set minimal mapping quality (default:0) Default value: '0'"
    inputBinding:
      position: 101
      prefix: -min_mapq
  - id: txt
    type:
      - 'null'
      - boolean
    doc: "Writes TXT format instead of qcML. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -txt
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads used for coverage calculation. Default value: '1'"
    inputBinding:
      position: 101
      prefix: -threads
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
    doc: "Output qcML file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
