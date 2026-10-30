cwlVersion: v1.2
class: CommandLineTool
baseCommand: SomaticQC
label: ngs-bits_SomaticQC
doc: "Calculates QC metrics based on tumor-normal pairs. SomaticQC integrates the output of the other QC tools and adds several metrics specific for tumor-normal pairs. All tools produce qcML, a generic XML format for QC of -omics experiments, which we adapted for NGS.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "BED file containing regions which are ignored in TMB calculation."
    inputBinding:
      position: 1
      prefix: -blacklist
  - id: build
    type:
      - 'null'
      - string
    doc: "Genome build used to generate the input. Valid: 'hg19,hg38'"
    inputBinding:
      position: 2
      prefix: -build
  - id: links
    type:
      - 'null'
      - File[]
    doc: "Files that appear in the link part of the qcML file."
    inputBinding:
      position: 3
      prefix: -links
  - id: normal_bam
    type: File
    doc: "Input normal BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 4
      prefix: -normal_bam
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output qcML file. If unset, writes to STDOUT."
    inputBinding:
      position: 5
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
      position: 6
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 7
      prefix: --settings
  - id: skip_plots
    type:
      - 'null'
      - boolean
    doc: "Skip plots (intended to increase speed of automated tests)."
    inputBinding:
      position: 8
      prefix: -skip_plots
  - id: somatic_vcf
    type: File
    doc: "Input somatic VCF file."
    inputBinding:
      position: 9
      prefix: -somatic_vcf
  - id: target_bed
    type:
      - 'null'
      - File
    doc: "Target file used for tumor and normal experiment."
    inputBinding:
      position: 10
      prefix: -target_bed
  - id: target_exons
    type:
      - 'null'
      - File
    doc: "BED file containing target exons, neccessary for TMB calculation. Please provide a file that contains the coordinates of all exons in the reference genome."
    inputBinding:
      position: 11
      prefix: -target_exons
  - id: tsg_bed
    type:
      - 'null'
      - File
    doc: "BED file containing regions of tumor suppressor genes for TMB calculation."
    inputBinding:
      position: 12
      prefix: -tsg_bed
  - id: tumor_bam
    type: File
    doc: "Input tumor BAM/CRAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 13
      prefix: -tumor_bam
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output qcML file. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
