cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesSubset
label: ucsc-mafspeciessubset
doc: "Extract a subset of species from a MAF file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspeciessubset:482--h0b57e2e_0
stdout: ucsc-mafspeciessubset.out
