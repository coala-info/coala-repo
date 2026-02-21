cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirdeep-p2
label: mirdeep-p2
doc: "miRDeep-P2 is a tool for plant miRNA identification. (Note: The provided text
  contains system error messages regarding container image conversion and disk space,
  rather than the tool's help documentation.)\n\nTool homepage: https://sourceforge.net/projects/mirdp2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep-p2:1.1.4--hdfd78af_0
stdout: mirdeep-p2.out
