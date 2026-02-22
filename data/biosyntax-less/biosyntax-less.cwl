cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosyntax-less
label: biosyntax-less
doc: "A syntax-highlighting pager for biological data formats. (Note: The provided
  text contains system error messages regarding disk space and container conversion
  rather than the tool's help documentation.)"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-less:v1.0.0b-1-deb_cv1
stdout: biosyntax-less.out
