cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomicassertions
label: genomicassertions
doc: "A tool for genomic assertions (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/ClinSeq/genomicassertions"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomicassertions:0.2.5--py35_0
stdout: genomicassertions.out
