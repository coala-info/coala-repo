cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel
label: parallel
doc: "The provided text does not contain help information or a description for the
  tool 'parallel'. It consists of environment information, perl warnings, and a list
  of 'command not found' errors for various bioinformatics tools.\n\nTool homepage:
  https://github.com/PaddlePaddle/Paddle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel:20180322-0
stdout: parallel.out
