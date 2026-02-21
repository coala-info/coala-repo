cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-join
label: tandem-genotypes_tandem-genotypes-join
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log. No arguments could be extracted.\n\nTool
  homepage: https://github.com/mcfrith/tandem-genotypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes_tandem-genotypes-join.out
