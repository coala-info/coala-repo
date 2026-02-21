cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq2fasta
label: igda-script_fastq2fasta
doc: "A tool to convert FASTQ files to FASTA format (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_fastq2fasta.out
