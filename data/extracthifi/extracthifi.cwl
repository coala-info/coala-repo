cwlVersion: v1.2
class: CommandLineTool
baseCommand: extracthifi
label: extracthifi
doc: "Extract HiFi reads from PacBio data\n\nTool homepage: https://github.com/PacificBiosciences/extracthifi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extracthifi:1.0.0--0
stdout: extracthifi.out
