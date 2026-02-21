cwlVersion: v1.2
class: CommandLineTool
baseCommand: rock
label: rock
doc: "The provided text contains execution logs rather than help documentation. No
  description or arguments could be extracted from the input.\n\nTool homepage: https://gitlab.pasteur.fr/vlegrand/ROCK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rock:2.0--h4ac6f70_2
stdout: rock.out
