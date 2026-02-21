cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesv
label: snakesv
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container execution environment.\n\nTool homepage:
  https://github.com/RajLabMSSM/snakeSV/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesv:0.8--py311hdfd78af_1
stdout: snakesv.out
