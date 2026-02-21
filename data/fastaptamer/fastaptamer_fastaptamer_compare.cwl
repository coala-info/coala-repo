cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_compare
label: fastaptamer_fastaptamer_compare
doc: "A tool from the FASTAptamer suite for comparing sequence populations between
  two different datasets.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer_fastaptamer_compare.out
