cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq2fasta
label: igda-script_fastq2fasta
doc: "Convert a FASTQ file to FASTA (uses bioawk).\nUsage: fastq2fasta fastqfile fastafile\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: fastqfile
    type: File
    doc: "input FASTQ file"
    inputBinding:
      position: 1
  - id: fastafile
    type: string
    doc: "output FASTA file name"
    inputBinding:
      position: 2
outputs:
  - id: out_fastafile
    type: File
    doc: "output FASTA file"
    outputBinding:
      glob: $(inputs.fastafile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
