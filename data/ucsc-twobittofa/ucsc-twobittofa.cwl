cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitToFa
label: ucsc-twobittofa
doc: "Convert all or part of a .2bit file to fasta format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_2bit
    type: File
    doc: Input .2bit file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: Restrict output to regions defined in this BED file
    inputBinding:
      position: 102
      prefix: -bed
  - id: end
    type:
      - 'null'
      - int
    doc: End at this position (non-inclusive)
    inputBinding:
      position: 102
      prefix: -end
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Convert masked genomes to upper case
    inputBinding:
      position: 102
      prefix: -noMask
  - id: seq
    type:
      - 'null'
      - string
    doc: Restrict to this sequence name
    inputBinding:
      position: 102
      prefix: -seq
  - id: start
    type:
      - 'null'
      - int
    doc: Start at this position (0-based)
    default: 0
    inputBinding:
      position: 102
      prefix: -start
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Directory to put the universal data cache
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: output_fasta
    type: File
    doc: Output fasta file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobittofa:482--hdc0a859_0
