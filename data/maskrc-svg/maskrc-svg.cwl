cwlVersion: v1.2
class: CommandLineTool
baseCommand: maskrc-svg
label: maskrc-svg
doc: "A tool for masking recombination in a sequence alignment (Note: The provided
  text is a container execution error and does not contain help documentation).\n\n
  Tool homepage: https://github.com/kwongj/maskrc-svg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maskrc-svg:0.5--0
stdout: maskrc-svg.out
