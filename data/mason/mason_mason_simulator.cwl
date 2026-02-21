cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_simulator
label: mason_mason_simulator
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image due to insufficient
  disk space.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.12--haf24da9_1
stdout: mason_mason_simulator.out
