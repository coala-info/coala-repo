cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-prof
label: profnet-prof
doc: "A tool for protein profile neural network predictions (Note: The provided help
  text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/stas990/ProfNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-prof:v1.0.22-6-deb_cv1
stdout: profnet-prof.out
