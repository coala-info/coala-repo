cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesSubset
label: ucsc-maftosnpbed_mafSpeciesSubset
doc: "Extract a subset of species from a MAF (Multiple Alignment Format) file.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
stdout: ucsc-maftosnpbed_mafSpeciesSubset.out
