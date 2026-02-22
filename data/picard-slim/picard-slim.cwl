cwlVersion: v1.2
class: CommandLineTool
baseCommand: picard-slim
label: picard-slim
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a failed container image build/pull due to insufficient
  disk space.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard-slim:3.4.0--hdfd78af_0
stdout: picard-slim.out
