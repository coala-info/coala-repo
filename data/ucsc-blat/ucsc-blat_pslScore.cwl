cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslScore
label: ucsc-blat_pslScore
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error logs indicating a failure to fetch or build the OCI image.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat_pslScore.out
