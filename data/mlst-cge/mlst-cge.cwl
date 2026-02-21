cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst-cge
label: mlst-cge
doc: "Multi-Locus Sequence Typing (MLST) tool (Note: The provided text is a container
  runtime error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://bitbucket.org/genomicepidemiology/mlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst-cge:2.0.9--hdfd78af_0
stdout: mlst-cge.out
