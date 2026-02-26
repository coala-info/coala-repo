cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesSubset
label: ucsc-mafspeciessubset
doc: "Extract a subset of species from a MAF (Multiple Alignment Format) file.\n\n\
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: species_list
    type: File
    doc: File containing the list of species to keep, one per line
    inputBinding:
      position: 2
outputs:
  - id: output_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspeciessubset:482--h0b57e2e_0
