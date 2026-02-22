cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools
label: pairtools
doc: "The provided text contains error logs and system messages rather than the tool's
  help documentation. As a result, no arguments or descriptions could be extracted.\n\
  \nTool homepage: https://github.com/mirnylab/pairtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
stdout: pairtools.out
