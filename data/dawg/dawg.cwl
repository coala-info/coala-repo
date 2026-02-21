cwlVersion: v1.2
class: CommandLineTool
baseCommand: dawg
label: dawg
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'dawg'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/reedacartwright/dawg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dawg:2.0.beta1--h81a73ca_1
stdout: dawg.out
