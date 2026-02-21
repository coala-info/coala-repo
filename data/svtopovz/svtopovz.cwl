cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtopovz
label: svtopovz
doc: "A tool for structural variant visualization (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/PacificBiosciences/HiFi-SVTopo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtopovz:0.3.0--pyhdfd78af_0
stdout: svtopovz.out
