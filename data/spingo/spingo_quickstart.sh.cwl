cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo_quickstart.sh
label: spingo_quickstart.sh
doc: "Quickstart script for SPINGO (Species-level Identification of Next-Generation
  Sequences). Note: The provided text appears to be a container execution log rather
  than help text, and no command-line arguments were identified.\n\nTool homepage:
  https://github.com/homedepot/spingo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo_quickstart.sh.out
