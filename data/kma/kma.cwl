cwlVersion: v1.2
class: CommandLineTool
baseCommand: kma
label: kma
doc: "KMA is a mapping method designed to map raw reads directly against redundant
  databases, in an ultra-fast manner using seed-and-extend.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/kma"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma.out
