cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniprot-id-mapper
label: uniprot-id-mapper
doc: "A tool for mapping UniProt identifiers. (Note: The provided text contains system
  error logs regarding a container build failure and does not include the tool's help
  documentation or argument definitions.)\n\nTool homepage: https://github.com/David-Araripe/UniProtMapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniprot-id-mapper:1.1.4--pyh7e72e81_0
stdout: uniprot-id-mapper.out
