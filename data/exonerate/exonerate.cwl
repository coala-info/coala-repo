cwlVersion: v1.2
class: CommandLineTool
baseCommand: exonerate
label: exonerate
doc: "Exonerate is a generic tool for sequence alignment. (Note: The provided help
  text contains only container runtime error messages and no actual command-line argument
  definitions.)\n\nTool homepage: https://www.ebi.ac.uk/about/vertebrate-genomics/software/exonerate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/exonerate:2.4.0--h09da616_5
stdout: exonerate.out
