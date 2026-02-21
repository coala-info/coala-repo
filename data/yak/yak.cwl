cwlVersion: v1.2
class: CommandLineTool
baseCommand: yak
label: yak
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'yak'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/lh3/yak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yak:0.1--h577a1d6_6
stdout: yak.out
