cwlVersion: v1.2
class: CommandLineTool
baseCommand: sonlib
label: sonlib
doc: "sonLib is a library for sequence analysis. (Note: The provided text is a container
  build error log and does not contain command-line help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/benedictpaten/sonLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sonlib:2.0.dev88--py39he47c912_1
stdout: sonlib.out
