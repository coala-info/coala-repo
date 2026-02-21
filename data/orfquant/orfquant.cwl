cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfquant
label: orfquant
doc: "ORFquant is a tool for the quantification of Open Reading Frames (ORFs). (Note:
  The provided text contains system error messages regarding container image extraction
  and does not include the actual help documentation or argument list.)\n\nTool homepage:
  https://github.com/ohlerlab/ORFquant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfquant:1.1.0--r44h9ee0642_6
stdout: orfquant.out
