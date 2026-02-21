cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortreadconnector_short_read_connector_linker.sh
label: shortreadconnector_short_read_connector_linker.sh
doc: "A script from the ShortReadConnector suite. Note: The provided text contains
  execution logs and error messages rather than help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortreadconnector:1.1.3--0
stdout: shortreadconnector_short_read_connector_linker.sh.out
