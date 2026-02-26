cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi_reformat_fastq
label: umitools_reformat_fastq
doc: "A script to reformat reads in a UMI fastq file so that the name of each record
  contains the UMI. This script is also known as umitools extract.\n\nTool homepage:
  https://github.com/weng-lab/umitools"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging mode
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: left
    type: File
    doc: the input fastq file for r1.
    inputBinding:
      position: 101
      prefix: --left
  - id: quality
    type:
      - 'null'
      - int
    doc: Quality (phred quality score) cutoff for UMI.Default is 13, that is UMI
      with qualities >= 13 willbe kept. This program assumes the phred quality 
      scoresin the fastq file are using sanger format
    default: 13
    inputBinding:
      position: 101
      prefix: --quality
  - id: right
    type: File
    doc: the input fastq file for r2.
    inputBinding:
      position: 101
      prefix: --right
  - id: umi_locator
    type:
      - 'null'
      - string
    doc: Set the UMI locators. If you have multiple, separate them by comma. 
      e.g. GGG,TCA,ATC
    default: GGG,TCA,ATC
    inputBinding:
      position: 101
      prefix: --umi-locator
  - id: umi_padding
    type:
      - 'null'
      - string
    doc: Set the nucleotide (for preventing ligation bias) after the UMI 
      locators. If you have multiple, separate them by comma. e.g. A,C,G,T. The 
      quality for this nt is sometimes low, so the default is all possible four 
      nucleotides
    default: A,C,G,T,N
    inputBinding:
      position: 101
      prefix: --umi-padding
  - id: umi_pattern
    type:
      - 'null'
      - string
    doc: Set the UMI patterns.
    default: None
    inputBinding:
      position: 101
      prefix: --umi-pattern
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Also include detailed stats for UMI and padding usage
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: left_out
    type: File
    doc: the output fastq file for r1
    outputBinding:
      glob: $(inputs.left_out)
  - id: right_out
    type: File
    doc: the output fastq file for r2
    outputBinding:
      glob: $(inputs.right_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
