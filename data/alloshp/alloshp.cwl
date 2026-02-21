cwlVersion: v1.2
class: CommandLineTool
baseCommand: alloshp
label: alloshp
doc: "A tool for allosteric site prediction (Note: The provided help text contains
  container build logs rather than tool usage information).\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
stdout: alloshp.out
