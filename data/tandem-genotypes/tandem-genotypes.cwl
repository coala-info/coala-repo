cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes
label: tandem-genotypes
doc: "The provided text does not contain help information for the tool, as it appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes.out
