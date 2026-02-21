cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist
label: tqdist
doc: "A tool for computing triplet and quartet distances between trees. Note: The
  provided input text contains error logs from a container runtime and does not include
  the actual help text or argument definitions.\n\nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist.out
