cwlVersion: v1.2
class: CommandLineTool
baseCommand: straitrazor
label: straitrazor
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/Ahhgust/STRaitRazor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h9948957_7
stdout: straitrazor.out
