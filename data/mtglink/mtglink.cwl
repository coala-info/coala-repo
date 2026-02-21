cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtglink
label: mtglink
doc: "MTG-Link is a tool for linking genome assemblies using long reads. (Note: The
  provided help text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink.out
