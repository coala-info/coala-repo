cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit5_phase_rare
label: shapeit5_phase_rare
doc: "The provided text is an error log indicating a container build failure ('no
  space left on device') and does not contain help documentation or argument definitions
  for the tool.\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
stdout: shapeit5_phase_rare.out
