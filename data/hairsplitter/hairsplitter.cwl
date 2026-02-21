cwlVersion: v1.2
class: CommandLineTool
baseCommand: hairsplitter
label: hairsplitter
doc: "A tool for processing or splitting data (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/RolandFaure/HairSplitter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hairsplitter:1.9.10--h8b7377a_1
stdout: hairsplitter.out
