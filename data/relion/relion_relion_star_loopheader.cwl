cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_star_loopheader
label: relion_relion_star_loopheader
doc: "Print the header of a STAR-file loop for the given labels.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: labels
    type:
      type: array
      items: string
    doc: Metadata labels, for example rlnImageName rlnDefocusU
    inputBinding:
      position: 1
outputs:
  - id: header
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_star_loopheader.out
