cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-count
label: fastq-count
doc: "The provided text does not contain a description of the tool; it contains system
  logs and a fatal error regarding container image building.\n\nTool homepage: https://github.com/sndrtj/fastq-count"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-count:0.1.0--h031d066_5
stdout: fastq-count.out
