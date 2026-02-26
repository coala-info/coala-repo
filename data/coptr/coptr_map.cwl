cwlVersion: v1.2
class: CommandLineTool
baseCommand: coptr_map
label: coptr_map
doc: "Map reads to a database index.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: index
    type: string
    doc: Name of database index.
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: File or folder containing fastq reads to map. If a folder, the 
      extension for each fastq must be one of [.fastq, .fq, .fastq.gz, fq.gz]
    inputBinding:
      position: 2
  - id: bt2_k
    type:
      - 'null'
      - int
    doc: (Default 10). Number of alignments to report. Passed to -k flag of 
      bowtie2.
    default: 10
    inputBinding:
      position: 103
      prefix: --bt2-k
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Set for paired end reads. Assumes fastq files end in _1.* and _2.*
    inputBinding:
      position: 103
      prefix: --paired
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie2 mapping.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_folder
    type: Directory
    doc: Folder to save mapped reads. BAM files are output here.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
