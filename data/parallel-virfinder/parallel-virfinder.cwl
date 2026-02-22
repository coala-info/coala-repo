cwlVersion: v1.2
class: CommandLineTool
baseCommand: parallel-virfinder
label: parallel-virfinder
doc: "A tool for parallelized viral sequence identification (Note: The provided help
  text contained only system error messages and no usage information).\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/parallel-virfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-virfinder:0.3.1--py310hdfd78af_0
stdout: parallel-virfinder.out
