cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfServer
label: ucsc-blat_gfServer
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a failure to fetch the OCI image.\n\n
  Tool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat_gfServer.out
