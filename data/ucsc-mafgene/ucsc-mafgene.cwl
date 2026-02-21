cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafGene
label: ucsc-mafgene
doc: "The provided text does not contain help information for the tool. It contains
  container execution logs and a fatal error indicating a failure to build or fetch
  the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafgene:490--ha62e71f_1
stdout: ucsc-mafgene.out
