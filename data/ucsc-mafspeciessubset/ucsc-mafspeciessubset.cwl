cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSpeciesSubset
label: ucsc-mafspeciessubset
doc: "Extract a maf that just has a subset of species.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_maf
    type: File
    doc: Input MAF file where the sequence sources are either simple species names,
      or species.something
    inputBinding:
      position: 1
  - id: species_lst
    type: File
    doc: File with a list of species to keep
    inputBinding:
      position: 2
  - id: out_maf
    type: string
    doc: Output MAF file name. Columns that are all - or . in the reduced species set
      are removed, as are lines for species not in species.lst.
    inputBinding:
      position: 3
  - id: keep_first
    type:
      - 'null'
      - boolean
    doc: If set, keep the first 'a' line in a maf no matter what. Useful for mafFrag
      results where this is used for the gene name.
    inputBinding:
      position: 101
      prefix: -keepFirst
outputs:
  - id: out_out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: $(inputs.out_maf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafspeciessubset:482--h0b57e2e_0
