cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2query
label: ms2query
doc: "MS2Query is a tool for searching MS2 spectra against a library. (Note: The provided
  text was an error log and did not contain help information.)\n\nTool homepage: https://github.com/iomega/ms2query"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2query:1.5.4--pyhdfd78af_0
stdout: ms2query.out
