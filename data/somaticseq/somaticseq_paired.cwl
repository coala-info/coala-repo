cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - somaticseq
  - paired
label: somaticseq_paired
doc: "Run somatic variant callers in paired mode\n\nTool homepage: http://bioinform.github.io/somaticseq/"
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
  - id: indelocator_vcf
    type:
      - 'null'
      - File
    doc: Indelocator VCF
    inputBinding:
      position: 101
      prefix: --indelocator-vcf
  - id: jsm_vcf
    type:
      - 'null'
      - File
    doc: JointSNVMix2 VCF
    inputBinding:
      position: 101
      prefix: --jsm-vcf
  - id: lofreq_indel
    type:
      - 'null'
      - File
    doc: LoFreq VCF
    inputBinding:
      position: 101
      prefix: --lofreq-indel
  - id: lofreq_snv
    type:
      - 'null'
      - File
    doc: LoFreq VCF
    inputBinding:
      position: 101
      prefix: --lofreq-snv
  - id: muse_vcf
    type:
      - 'null'
      - File
    doc: MuSE VCF
    inputBinding:
      position: 101
      prefix: --muse-vcf
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
  - id: normal_bam_file
    type: File
    doc: Normal BAM File
    inputBinding:
      position: 101
      prefix: --normal-bam-file
  - id: normal_sample
    type:
      - 'null'
      - string
    doc: Normal Name
    inputBinding:
      position: 101
      prefix: --normal-sample
  - id: platypus_vcf
    type:
      - 'null'
      - File
    doc: Platypus VCF
    inputBinding:
      position: 101
      prefix: --platypus-vcf
  - id: scalpel_vcf
    type:
      - 'null'
      - File
    doc: Scalpel VCF
    inputBinding:
      position: 101
      prefix: --scalpel-vcf
  - id: somaticsniper_vcf
    type:
      - 'null'
      - File
    doc: SomaticSniper VCF
    inputBinding:
      position: 101
      prefix: --somaticsniper-vcf
  - id: strelka_indel
    type:
      - 'null'
      - File
    doc: Strelka VCF
    inputBinding:
      position: 101
      prefix: --strelka-indel
  - id: strelka_snv
    type:
      - 'null'
      - File
    doc: Strelka VCF
    inputBinding:
      position: 101
      prefix: --strelka-snv
  - id: tnscope_vcf
    type:
      - 'null'
      - File
    doc: TNscope VCF
    inputBinding:
      position: 101
      prefix: --tnscope-vcf
  - id: tumor_bam_file
    type: File
    doc: Tumor BAM File
    inputBinding:
      position: 101
      prefix: --tumor-bam-file
  - id: tumor_sample
    type:
      - 'null'
      - string
    doc: Tumor Name
    inputBinding:
      position: 101
      prefix: --tumor-sample
  - id: vardict_vcf
    type:
      - 'null'
      - File
    doc: VarDict VCF
    inputBinding:
      position: 101
      prefix: --vardict-vcf
  - id: varscan_indel
    type:
      - 'null'
      - File
    doc: VarScan2 VCF
    inputBinding:
      position: 101
      prefix: --varscan-indel
  - id: varscan_snv
    type:
      - 'null'
      - File
    doc: VarScan2 VCF
    inputBinding:
      position: 101
      prefix: --varscan-snv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somaticseq:3.11.1--pyhdfd78af_0
stdout: somaticseq_paired.out
