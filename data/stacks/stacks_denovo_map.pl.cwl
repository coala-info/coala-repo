cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovo_map.pl
label: stacks_denovo_map.pl
doc: "The provided text is a container runtime error log and does not contain help
  documentation for the tool.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_denovo_map.pl.out
