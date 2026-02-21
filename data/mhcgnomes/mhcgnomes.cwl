cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcgnomes
label: mhcgnomes
doc: "A tool for parsing and normalizing MHC nomenclature.\n\nTool homepage: https://github.com/til-unc/mhcgnomes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcgnomes:2.0--pyh7e72e81_0
stdout: mhcgnomes.out
