cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasclass
label: plasclass
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process due to insufficient disk space.\n
  \nTool homepage: https://github.com/Shamir-Lab/PlasClass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
stdout: plasclass.out
