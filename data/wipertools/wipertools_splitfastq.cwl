cwlVersion: v1.2
class: CommandLineTool
baseCommand: wipertools_splitfastq
label: wipertools_splitfastq
doc: "A tool for splitting FASTQ files (Note: The provided help text contains only
  container build errors and no usage information).\n\nTool homepage: https://github.com/mazzalab/fastqwiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
stdout: wipertools_splitfastq.out
