cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobasehttptools
label: biobasehttptools
doc: "A collection of HTTP-based tools for biological databases. Note: The provided
  help text contains only system logs and build errors, so specific arguments could
  not be extracted.\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools.out
