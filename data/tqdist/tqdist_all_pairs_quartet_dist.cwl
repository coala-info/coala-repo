cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_all_pairs_quartet_dist
label: tqdist_all_pairs_quartet_dist
doc: "The provided help text contains only container execution error messages and
  does not provide usage information or argument details for the tool.\n\nTool homepage:
  http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_all_pairs_quartet_dist.out
