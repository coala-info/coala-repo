cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqpuri
label: fastqpuri
doc: "FastqPuri is a light-weight and efficient quality control and purification tool
  for FASTQ files.\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r43h9d449c0_8
stdout: fastqpuri.out
