cwlVersion: v1.2
class: CommandLineTool
baseCommand: python PneumoCaT.py
label: pneumocat_PneumoCaT.py
doc: "PneumoCaT.py\n\nTool homepage: https://github.com/phe-bioinformatics/pneumocat/archive/v1.1.tar.gz"
inputs:
  - id: bowtie
    type:
      - 'null'
      - string
    doc: "please provide the path for bowtie2 [OPTIONAL];\n                      \
      \  defaults to bowtie2"
    default: bowtie2
    inputBinding:
      position: 101
      prefix: --bowtie
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: "if used, all bam files generated will be removed upon\n                \
      \        completion"
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: fastq_1
    type: File
    doc: Fastq file pair 1 [REQUIRED - OPTION 2]
    inputBinding:
      position: 101
      prefix: --fastq_1
  - id: fastq_2
    type: File
    doc: Fastq file pair 2 [REQUIRED - OPTION 2]
    inputBinding:
      position: 101
      prefix: --fastq_2
  - id: input_directory
    type: Directory
    doc: please provide the path to the directory contains the fastq files 
      [REQUIRED - OPTION 1]
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "please provide an output directory [OPTIONAL]; if none\n               \
      \         provided a pneumo_capsular_typing folder will be\n               \
      \         created in the directory containing the fastq files"
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: samtools
    type:
      - 'null'
      - string
    doc: "please provide the path for samtools [OPTIONAL];\n                     \
      \   defaults to samtools"
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use [OPTIONAL]; default=4
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_database
    type:
      - 'null'
      - string
    doc: "variant database [OPTIONAL]; defaults to\n                        streptococcus-pneumoniae-ctvdb
      in the github directory"
    default: streptococcus-pneumoniae-ctvdb in the github directory
    inputBinding:
      position: 101
      prefix: --variant_database
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumocat:1.2.1--0
stdout: pneumocat_PneumoCaT.py.out
