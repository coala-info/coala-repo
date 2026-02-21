cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks_ref_map.pl
label: stacks_ref_map.pl
doc: "The provided text is a container execution error log and does not contain the
  help documentation for stacks_ref_map.pl. As a result, no arguments could be extracted.\n
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_ref_map.pl.out
