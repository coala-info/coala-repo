cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepstats
label: deepstats
doc: "A tool for deep learning statistics (Note: The provided help text contains only
  container runtime error messages and does not list specific tool arguments).\n\n
  Tool homepage: https://github.com/gtrichard/deepStats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepstats:0.4--hdfd78af_1
stdout: deepstats.out
