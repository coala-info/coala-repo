cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_count
label: fastaptamer_fastaptamer_count
doc: "The provided text does not contain help information for the tool, as it consists
  of container runtime error messages regarding disk space.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer_fastaptamer_count.out
