cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit5_switch
label: shapeit5_switch
doc: "A tool from the SHAPEIT5 suite. (Note: The provided help text contains only
  system error logs regarding a failed container build and does not list command-line
  arguments.)\n\nTool homepage: https://odelaneau.github.io/shapeit5/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2
stdout: shapeit5_switch.out
