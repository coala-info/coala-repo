cwlVersion: v1.2
class: CommandLineTool
baseCommand: TrioMaternalContamination
label: ngs-bits_TrioMaternalContamination
doc: "Detects maternal contamination of a child using SNPs from parents. Determines the percentage of heterozygous SNPs passed on to the child from mother/father. This percentage should be similar for mother/father. If it is much higher for the mother, maternal contamination is likely.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam_c
    type: File
    doc: "Input BAM/CRAM file of child."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
      prefix: -bam_c
  - id: bam_f
    type: File
    doc: "Input BAM/CRAM file of father."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 2
      prefix: -bam_f
  - id: bam_m
    type: File
    doc: "Input BAM/CRAM file of mother."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 3
      prefix: -bam_m
  - id: build
    type:
      - 'null'
      - string
    doc: "Genome build used to generate the input. Valid: 'hg19,hg38'"
    inputBinding:
      position: 4
      prefix: -build
  - id: min_alt_count
    type:
      - 'null'
      - int
    doc: "Minimum number of alternate observations for calling a SNP."
    inputBinding:
      position: 5
      prefix: -min_alt_count
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth for calling SNPs."
    inputBinding:
      position: 6
      prefix: -min_depth
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output file. If unset, writes to STDOUT."
    inputBinding:
      position: 7
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
    type:
      - 'null'
      - File
    doc: "Output file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
