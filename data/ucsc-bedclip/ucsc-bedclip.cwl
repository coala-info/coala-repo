cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedClip
label: ucsc-bedclip
doc: "Remove lines from bed file that refer to off-chromosome locations.\n\nTool\
  \ homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
stderr: $(inputs.out_bed_path).log
inputs:
  - id: input_bed
    type: File
    doc: Input BED file (can be gzipped)
    inputBinding:
      position: 11
  - id: chrom_sizes
    type: File
    doc: 'Two-column file: <chromosome name> <size in bases>'
    inputBinding:
      position: 12
  - id: out_bed_path
    type: string
    doc: Name of the output BED file
    inputBinding:
      position: 13
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Truncate items that span ends of chrom instead of the default of dropping
      the items
    inputBinding:
      position: 1
      prefix: -truncate
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set to 2 to get the list of lines clipped and why (written to standard error)
    inputBinding:
      position: 2
      prefix: -verbose=
      separate: false
outputs:
  - id: out_bed
    type: File
    doc: Output BED file with off-chromosome lines removed
    outputBinding:
      glob: $(inputs.out_bed_path)
  - id: log
    type: File
    doc: Messages from the tool (standard error)
    outputBinding:
      glob: $(inputs.out_bed_path).log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedclip:482--h0b57e2e_0
