cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-screen
label: fastq-screen_fastq_screen
doc: "FastQ Screen allows you to screen a library of sequences in FastQ format against
  a set of sequence databases so you can see if the composition of the library matches
  what you expect.\n\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-screen:0.16.0--pl5321hdfd78af_0
stdout: fastq-screen_fastq_screen.out
