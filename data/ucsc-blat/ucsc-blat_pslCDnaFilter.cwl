cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCDnaFilter
label: ucsc-blat_pslCDnaFilter
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat_pslCDnaFilter.out
