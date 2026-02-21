cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastool
label: fastool
doc: "A tool for fasta/fastq manipulation (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/tobe-fe-dalao/fastool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastool:0.1.4--h7132678_6
stdout: fastool.out
