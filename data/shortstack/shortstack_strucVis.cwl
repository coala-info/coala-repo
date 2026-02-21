cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortstack_strucVis
label: shortstack_strucVis
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages indicating a failure to fetch or build the image.\n
  \nTool homepage: https://github.com/MikeAxtell/ShortStack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0
stdout: shortstack_strucVis.out
