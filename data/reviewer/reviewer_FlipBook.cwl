cwlVersion: v1.2
class: CommandLineTool
baseCommand: reviewer_FlipBook
label: reviewer_FlipBook
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/Illumina/REViewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reviewer:0.2.7--h48da230_0
stdout: reviewer_FlipBook.out
