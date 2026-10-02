cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedGraphToBigWig
label: ucsc-bedgraphtobigwig
doc: 'Convert a bedGraph file to bigWig format (bbi version: 4).'
inputs:
  - id: in_bedgraph
    type: File
    doc: 'Four column file in the format: <chrom> <start> <end> <value>'
    inputBinding:
      position: 1
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: 'Two-column file/URL: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: out_bw
    type: string
    doc: Output indexed big wig file
    inputBinding:
      position: 3
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree.
    inputBinding:
      position: 104
      prefix: -blockSize=
      separate: false
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level.
    inputBinding:
      position: 104
      prefix: -itemsPerSlot=
      separate: false
  - id: sizes_is_bb
    type:
      - 'null'
      - boolean
    doc: If set, the chrom.sizes file is assumed to be a bigBed file.
    inputBinding:
      position: 104
      prefix: -sizesIsBb
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression.
    inputBinding:
      position: 104
      prefix: -unc
outputs:
  - id: out_out_bw
    type: File
    doc: Output indexed big wig file
    outputBinding:
      glob: $(inputs.out_bw)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgraphtobigwig:482--hdc0a859_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
