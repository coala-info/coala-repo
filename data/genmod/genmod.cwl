cwlVersion: v1.2
class: CommandLineTool
baseCommand: genmod
label: genmod
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages.\n\nTool homepage: http://github.com/moonso/genmod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
stdout: genmod.out
