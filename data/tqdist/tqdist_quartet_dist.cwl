cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_quartet_dist
label: tqdist_quartet_dist
doc: "A tool for computing the quartet distance between trees. (Note: The provided
  help text contains container execution errors and does not list usage or arguments.)\n
  \nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_quartet_dist.out
