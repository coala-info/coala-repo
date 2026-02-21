cwlVersion: v1.2
class: CommandLineTool
baseCommand: short-read-connector
label: short-read-connector
doc: "Short-read-connector (Note: The provided text is a container execution error
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h43eeafb_1
stdout: short-read-connector.out
