cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tiny-count
  - tiny
label: tiny-count_tiny
doc: "A tool from the tiny-count package (Note: The provided text contains build logs
  and error messages rather than command-line help documentation. No arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/MontgomeryLab/tinyRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiny-count:1.5.0--py39h9948957_2
stdout: tiny-count_tiny.out
