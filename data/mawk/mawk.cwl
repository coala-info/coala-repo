cwlVersion: v1.2
class: CommandLineTool
baseCommand: mawk
label: mawk
doc: "The provided text is an error message regarding a container build failure and
  does not contain help documentation for the tool. Mawk is typically an interpreter
  for the AWK programming language.\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mawk:1.3.4--h7b50bb2_11
stdout: mawk.out
