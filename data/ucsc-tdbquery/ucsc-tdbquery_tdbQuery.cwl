cwlVersion: v1.2
class: CommandLineTool
baseCommand: tdbQuery
label: ucsc-tdbquery_tdbQuery
doc: "The provided text does not contain help information for the tool; it is a fatal
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tdbquery:482--h0b57e2e_0
stdout: ucsc-tdbquery_tdbQuery.out
