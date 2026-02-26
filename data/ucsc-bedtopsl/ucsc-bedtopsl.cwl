cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToPsl
label: ucsc-bedtopsl
doc: "Convert BED format to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: name and size)'
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Input BED file
    inputBinding:
      position: 2
  - id: keep_mask
    type:
      - 'null'
      - boolean
    doc: Keep masked characters (lowercase)
    inputBinding:
      position: 103
      prefix: -keepMask
outputs:
  - id: psl_file
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0
