cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: ucsc-wigtobigwig
doc: 'Convert ascii format wig file (in fixedStep, variableStep or bedGraph format)
  to binary big wig format (bbi version: 4).'
inputs:
  - id: in_wig
    type: File
    doc: Where in.wig is in one of the ascii wiggle formats, but not including 
      track lines
    inputBinding:
      position: 1
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: 'chrom.sizes is a two-column file/URL: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: out_bw
    type: string
    doc: out.bw is the output indexed big wig file
    inputBinding:
      position: 3
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree. Default 256
    inputBinding:
      position: 104
      prefix: -blockSize=
      separate: false
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level. Default 1024
    inputBinding:
      position: 104
      prefix: -itemsPerSlot=
      separate: false
  - id: clip
    type:
      - 'null'
      - boolean
    doc: If set just issue warning messages rather than dying if wig file 
      contains items off end of chromosome or chromosomes that are not in the 
      chrom.sizes file.
    inputBinding:
      position: 104
      prefix: -clip
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression.
    inputBinding:
      position: 104
      prefix: -unc
  - id: fixed_summaries
    type:
      - 'null'
      - boolean
    doc: If set, use a predefined sequence of summary levels.
    inputBinding:
      position: 104
      prefix: -fixedSummaries
  - id: keep_all_chromosomes
    type:
      - 'null'
      - boolean
    doc: If set, store all chromosomes in b-tree.
    inputBinding:
      position: 104
      prefix: -keepAllChromosomes
outputs:
  - id: out_out_bw
    type: File
    doc: out.bw is the output indexed big wig file
    outputBinding:
      glob: $(inputs.out_bw)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wigtobigwig:482--hdc0a859_1
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
