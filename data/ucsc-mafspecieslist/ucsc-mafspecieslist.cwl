cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesList
label: ucsc-mafspecieslist
doc: "List species in a Multiple Alignment Format (MAF) file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file to extract species list from
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspecieslist:482--h0b57e2e_0
stdout: ucsc-mafspecieslist.out
