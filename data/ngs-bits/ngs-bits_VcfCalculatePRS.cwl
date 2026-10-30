cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfCalculatePRS
label: ngs-bits_VcfCalculatePRS
doc: "Calculates the Polgenic Risk Score(s) for a sample. The PRS VCF files have to contain WEIGHT and POP_AF fields in the INFO column. Additionally some information about the PRS score is required in the VCF header. An example VCF file can be found at https://github.com/imgag/ngs-bits/blob/master/src/tools-TEST/data_in/VcfCalculatePRS_prs2.vcf\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bam
    type: File
    doc: "BAM file corresponding to the VCF."
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
  - id: details
    type:
      - 'null'
      - string
    doc: "Output TSV containing each variant with weight, allele count and population AF."
    inputBinding:
      position: 2
      prefix: -details
  - id: input_file
    type: File
    doc: "Tabix indexed VCF.GZ file of a sample."
    secondaryFiles:
      - pattern: .tbi
        required: false
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
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Depth cutoff below which uncalled SNPs are considered not callable and POP_AF is used instead of genotype."
    inputBinding:
      position: 5
      prefix: -min_depth
  - id: output_path
    type: string
    doc: "Output TSV file containing Scores and PRS details"
    inputBinding:
      position: 6
      prefix: -out
  - id: prs
    type: File[]
    doc: "List of PRS VCFs."
    inputBinding:
      position: 7
      prefix: -prs
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset, 'reference_genome' from the 'settings.ini' file is used."
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
    doc: "Output TSV file containing Scores and PRS details"
    outputBinding:
      glob: $(inputs.output_path)
  - id: details_file
    type:
      - 'null'
      - File
    doc: "Output TSV containing each variant with weight, allele count and population AF."
    outputBinding:
      glob: $(inputs.details)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
