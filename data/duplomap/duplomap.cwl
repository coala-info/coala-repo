cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplomap
label: duplomap
doc: "A tool for mapping reads in segmental duplications. (Note: The provided text
  is a container runtime error log and does not contain help documentation or argument
  definitions.)\n\nTool homepage: https://gitlab.com/tprodanov/duplomap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duplomap:0.9.5--h577a1d6_4
stdout: duplomap.out
