cwlVersion: v1.2
class: CommandLineTool
baseCommand: segalign-full
label: segalign-full
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-full:0.1.2.7--hdfd78af_1
stdout: segalign-full.out
