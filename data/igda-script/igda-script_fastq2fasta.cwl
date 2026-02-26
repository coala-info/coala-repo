cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq2fasta
label: igda-script_fastq2fasta
doc: "Converts FASTQ format to FASTA format.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: fastqfile
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: fastafile
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
