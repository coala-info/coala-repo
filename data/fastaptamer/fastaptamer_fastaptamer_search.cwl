cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaptamer
  - search
label: fastaptamer_fastaptamer_search
doc: "The provided help text contains only system error messages regarding container
  image creation and does not include usage information or argument definitions for
  the tool.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer_fastaptamer_search.out
