cwlVersion: v1.2
class: CommandLineTool
baseCommand: somaticseq_single
label: somaticseq_single
doc: "SomaticSeq single mode\n\nTool homepage: http://bioinform.github.io/somaticseq/"
inputs:
  - id: arbitrary_indels
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional INDEL VCFs
    inputBinding:
      position: 101
      prefix: --arbitrary-indels
  - id: arbitrary_snvs
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional SNV VCFs
    inputBinding:
      position: 101
      prefix: --arbitrary-snvs
  - id: bam_file
    type: File
    doc: BAM File
    inputBinding:
      position: 101
      prefix: --bam-file
  - id: lofreq_vcf
    type:
      - 'null'
      - File
    doc: LoFreq VCF
    inputBinding:
      position: 101
      prefix: --lofreq-vcf
  - id: mutect2_vcf
    type:
      - 'null'
      - File
    doc: MuTect2 VCF
    inputBinding:
      position: 101
      prefix: --mutect2-vcf
  - id: mutect_vcf
    type:
      - 'null'
      - File
    doc: MuTect VCF
    inputBinding:
      position: 101
      prefix: --mutect-vcf
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample Name
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: scalpel_vcf
    type:
      - 'null'
      - File
    doc: Scalpel VCF
    inputBinding:
      position: 101
      prefix: --scalpel-vcf
  - id: strelka_vcf
    type:
      - 'null'
      - File
    doc: Strelka VCF
    inputBinding:
      position: 101
      prefix: --strelka-vcf
  - id: vardict_vcf
    type:
      - 'null'
      - File
    doc: VarDict VCF
    inputBinding:
      position: 101
      prefix: --vardict-vcf
  - id: varscan_vcf
    type:
      - 'null'
      - File
    doc: VarScan2 VCF
    inputBinding:
      position: 101
      prefix: --varscan-vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
stdout: somaticseq_single.out
