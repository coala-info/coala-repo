cwlVersion: v1.2
class: CommandLineTool
baseCommand: sativa
label: sativa
doc: "Semi-Automated Taxonomic Identification and Validation (Note: The provided text
  is a container build error log and does not contain help information or argument
  definitions.)\n\nTool homepage: https://github.com/amkozlov/sativa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sativa:0.9.3--py312h031d066_0
stdout: sativa.out
