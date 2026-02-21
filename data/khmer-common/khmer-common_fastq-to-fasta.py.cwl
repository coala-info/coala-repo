cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-to-fasta.py
label: khmer-common_fastq-to-fasta.py
doc: "A tool to convert FASTQ files to FASTA format. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  command-line arguments.)\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_fastq-to-fasta.py.out
