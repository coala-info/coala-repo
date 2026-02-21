cwlVersion: v1.2
class: CommandLineTool
baseCommand: president
label: president
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://gitlab.com/RKIBioinformaticsPipelines/president"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/president:0.6.8--pyhdfd78af_0
stdout: president.out
