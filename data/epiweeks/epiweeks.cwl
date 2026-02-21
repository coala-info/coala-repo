cwlVersion: v1.2
class: CommandLineTool
baseCommand: epiweeks
label: epiweeks
doc: "A tool for calculating epidemiological weeks. (Note: The provided input text
  contains container runtime error messages rather than CLI help documentation, so
  no arguments could be extracted.)\n\nTool homepage: https://github.com/dralshehri/epiweeks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epiweeks:2.4.0--pyhdfd78af_0
stdout: epiweeks.out
