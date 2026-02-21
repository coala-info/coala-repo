cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-screen
label: fastq-screen
doc: "\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-screen:0.16.0--pl5321hdfd78af_0
stdout: fastq-screen.out
