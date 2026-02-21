cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesList
label: ucsc-mafspecieslist
doc: "The provided text does not contain help information as it reflects a container
  engine error (FATAL: Unable to handle docker uri). Based on the tool name, this
  utility is typically used to list species in a Multiple Alignment Format (MAF) file.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspecieslist:482--h0b57e2e_0
stdout: ucsc-mafspecieslist.out
