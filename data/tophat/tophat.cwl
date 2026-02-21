cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat
label: tophat
doc: "TopHat is a fast splice junction mapper for RNA-Seq reads. (Note: The provided
  text is a container build error log and does not contain help documentation; arguments
  could not be extracted from the input.)\n\nTool homepage: http://ccb.jhu.edu/software/tophat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat:2.1.2--h3e6c209_0
stdout: tophat.out
