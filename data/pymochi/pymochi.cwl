cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymochi
label: pymochi
doc: "The provided text does not contain help information or documentation for the
  'pymochi' tool. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/lehner-lab/MoCHI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
stdout: pymochi.out
