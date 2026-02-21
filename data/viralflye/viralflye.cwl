cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralflye
label: viralflye
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/Dmitry-Antipov/viralFlye/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralflye:0.2--pyhdfd78af_0
stdout: viralflye.out
