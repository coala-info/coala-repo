cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophane
label: prophane
doc: "A tool for functional and taxonomic profiling of metaproteomes (Note: The provided
  text contains error logs rather than help text; no arguments could be extracted).\n
  \nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane.out
