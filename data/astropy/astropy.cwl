cwlVersion: v1.2
class: CommandLineTool
baseCommand: astropy
label: astropy
doc: "A community-developed core Python package for Astronomy. (Note: The provided
  text appears to be a container build log rather than CLI help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/astropy/astropy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astropy:6.1.7
stdout: astropy.out
