cwlVersion: v1.2
class: CommandLineTool
baseCommand: mreps
label: mreps
doc: "A tool for finding tandem repeats in DNA sequences. (Note: The provided help
  text contains only container runtime error messages and does not list specific tool
  arguments.)\n\nTool homepage: http://mreps.univ-mlv.fr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mreps:2.6.01--h7b50bb2_6
stdout: mreps.out
