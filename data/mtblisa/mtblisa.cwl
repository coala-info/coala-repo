cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtblisa
label: mtblisa
doc: "The provided text contains container runtime error messages and does not include
  help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/phnmnl/container-mtblisa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mtblisa:phenomenal-v0.10.2_cv0.7.14.102
stdout: mtblisa.out
