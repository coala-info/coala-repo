cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - uniprot-id-mapper
  - protmap
label: uniprot-id-mapper_protmap
doc: "UniProt ID mapping tool (protmap subcommand). Note: The provided text contains
  container runtime error logs rather than CLI help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/David-Araripe/UniProtMapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniprot-id-mapper:1.1.4--pyh7e72e81_0
stdout: uniprot-id-mapper_protmap.out
