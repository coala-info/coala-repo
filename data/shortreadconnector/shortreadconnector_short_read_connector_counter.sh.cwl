cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortreadconnector_short_read_connector_counter.sh
label: shortreadconnector_short_read_connector_counter.sh
doc: "ShortReadConnector counter script. (Note: The provided input text contains system
  logs and a fatal error rather than help documentation; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortreadconnector:1.1.3--0
stdout: shortreadconnector_short_read_connector_counter.sh.out
