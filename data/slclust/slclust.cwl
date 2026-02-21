cwlVersion: v1.2
class: CommandLineTool
baseCommand: slclust
label: slclust
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container image retrieval process.\n\nTool homepage: https://github.com/brianjohnhaas/SLCLUST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slclust:02022010--h077b44d_6
stdout: slclust.out
