cwlVersion: v1.2
class: CommandLineTool
baseCommand: simphyni
label: simphyni
doc: "Simphyni tool (Note: The provided text contains build logs and error messages
  rather than help documentation. No arguments could be extracted from the input.)\n
  \nTool homepage: https://github.com/jpeyemi/SimPhyNI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
stdout: simphyni.out
