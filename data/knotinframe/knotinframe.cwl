cwlVersion: v1.2
class: CommandLineTool
baseCommand: knotinframe
label: knotinframe
doc: "A tool for RNA pseudoknot prediction and frameshifting analysis. (Note: The
  provided text was an error message and did not contain usage instructions.)\n\n
  Tool homepage: https://bibiserv.cebitec.uni-bielefeld.de/knotinframe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knotinframe:2.3.2--h4ac6f70_0
stdout: knotinframe.out
