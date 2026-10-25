cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafAddQRows
label: ucsc-mafaddqrows_mafAddQRows
doc: "Add quality data to a maf\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: species_lst
    type: File
    doc: 'species.lst file where each line contains two fields: 1) species name, 2)
      directory where the .qac and .qdx files are located'
    inputBinding:
      position: 1
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 2
  - id: out_maf
    type: string
    doc: Output MAF file
    inputBinding:
      position: 3
  - id: quality_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The <species>.qac and <species>.qdx files named by species.lst. They are staged
      in the working directory, so a directory field of . in species.lst finds them.
  - id: divisor
    type:
      - 'null'
      - float
    doc: value to divide Q value by
    inputBinding:
      position: 103
      prefix: -divisor=
      separate: false
outputs:
  - id: out_out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '$(inputs.out_maf)'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.quality_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafaddqrows:482--h0b57e2e_0
