cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer
label: fastaptamer
doc: "The provided text contains container runtime errors (Apptainer/Singularity)
  and does not include the help documentation or usage instructions for the fastaptamer
  tool.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer.out
