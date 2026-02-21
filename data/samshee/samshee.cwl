cwlVersion: v1.2
class: CommandLineTool
baseCommand: samshee
label: samshee
doc: "A tool for SAM/BAM header editing and manipulation. (Note: The provided help
  text appears to be a container build log and does not contain argument definitions.)\n
  \nTool homepage: https://github.com/lit-regensburg/samshee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samshee:0.2.12--pyhdfd78af_0
stdout: samshee.out
