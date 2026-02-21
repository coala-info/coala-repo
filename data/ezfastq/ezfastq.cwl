cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezfastq
label: ezfastq
doc: "A tool for processing FASTQ files (Note: Provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/bioforensics/ezfastq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezfastq:0.2--pyhdfd78af_0
stdout: ezfastq.out
