cwlVersion: v1.2
class: CommandLineTool
baseCommand: short-read-connector_short_read_connector_linker.sh
label: short-read-connector_short_read_connector_linker.sh
doc: "A script for the short-read-connector tool. (Note: The provided text contains
  container runtime logs and error messages rather than command-line help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h43eeafb_1
stdout: short-read-connector_short_read_connector_linker.sh.out
