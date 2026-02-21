cwlVersion: v1.2
class: CommandLineTool
baseCommand: hitac
label: hitac
doc: "HiTAC (Hierarchical Taxonomic Classification). Note: The provided text contains
  container runtime error logs rather than command-line help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://gitlab.com/dacs-hpi/hitac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hitac:2.2.2--pyhdfd78af_1
stdout: hitac.out
