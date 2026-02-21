cwlVersion: v1.2
class: CommandLineTool
baseCommand: short-read-connector_short_read_connector_counter.sh
label: short-read-connector_short_read_connector_counter.sh
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container execution/build process.\n\nTool homepage:
  https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h43eeafb_1
stdout: short-read-connector_short_read_connector_counter.sh.out
