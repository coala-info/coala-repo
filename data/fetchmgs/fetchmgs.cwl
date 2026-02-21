cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetchmgs
label: fetchmgs
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building (no space left on device).\n\nTool homepage: https://github.com/motu-tool/FetchMGs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fetchmgs:2.1.2--pyh7e72e81_0
stdout: fetchmgs.out
