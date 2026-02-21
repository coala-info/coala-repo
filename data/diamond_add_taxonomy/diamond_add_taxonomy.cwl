cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - add-taxonomy
label: diamond_add_taxonomy
doc: "The provided text does not contain help information. It contains system log
  messages and a fatal error indicating a failure to build or run the container (no
  space left on device).\n\nTool homepage: https://github.com/pvanheus/diamond_add_taxonomy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
stdout: diamond_add_taxonomy.out
