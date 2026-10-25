cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafsInRegion
label: ucsc-mafsinregion
doc: "Extract MAFS in a genomic region\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: regions_bed
    type: File
    doc: BED file with the regions to extract
    inputBinding:
      position: 1
  - id: out_maf
    type: string
    doc: Output MAF file name, or output directory name when out_dir is set
    inputBinding:
      position: 2
  - id: in_mafs
    type:
      type: array
      items: File
    doc: Input MAF file(s)
    inputBinding:
      position: 3
  - id: out_dir
    type:
      - 'null'
      - boolean
    doc: Output separate files named by bed name field to outDir
    inputBinding:
      position: 101
      prefix: -outDir
  - id: keep_initial_gaps
    type:
      - 'null'
      - boolean
    doc: Keep alignment columns at the beginning and end of a block that are gapped
      in all species
    inputBinding:
      position: 101
      prefix: -keepInitialGaps
outputs:
  - id: out_out_maf
    type:
      - 'null'
      - File
    doc: Output MAF file (when out_dir is not set)
    outputBinding:
      glob: '$(inputs.out_dir ? [] : inputs.out_maf)'
  - id: out_out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with one MAF per region (when out_dir is set)
    outputBinding:
      glob: '$(inputs.out_dir ? inputs.out_maf : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsinregion:482--h0b57e2e_0
