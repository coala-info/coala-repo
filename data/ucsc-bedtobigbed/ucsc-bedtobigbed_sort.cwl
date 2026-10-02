cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToBigBed
label: ucsc-bedtobigbed_sort
doc: Convert bed file to bigBed.
inputs:
  - id: in_bed
    type: File
    doc: in.bed is in one of the ascii bed formats, but not including track 
      lines
    inputBinding:
      position: 1
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: 'chrom.sizes is a two-column file/URL: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: out_bb
    type: string
    doc: out.bb is the output indexed big bed file
    inputBinding:
      position: 3
  - id: type
    type:
      - 'null'
      - string
    doc: "N is between 3 and 15, optional (+) if extra 'bedPlus' fields, optional
      P specifies the number of extra fields. Not required, but preferred. Examples:
      -type=bed6 or -type=bed6+ or -type=bed6+3"
    inputBinding:
      position: 104
      prefix: -type=
      separate: false
  - id: as
    type:
      - 'null'
      - File
    doc: If you have non-standard 'bedPlus' fields, it's great to put a 
      definition of each field in a row in AutoSql format here.
    inputBinding:
      position: 104
      prefix: -as=
      separate: false
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
    doc: Number of data points bundled at lowest level. Default 512
    inputBinding:
      position: 104
      prefix: -itemsPerSlot=
      separate: false
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression.
    inputBinding:
      position: 104
      prefix: -unc
  - id: tab
    type:
      - 'null'
      - boolean
    doc: If set, expect fields to be tab separated, normally expects white space
      separator.
    inputBinding:
      position: 104
      prefix: -tab
  - id: extra_index
    type:
      - 'null'
      - type: array
        items: string
    doc: If set, make an index on each field in a comma separated list 
      extraIndex=name and extraIndex=name,id are commonly used.
    inputBinding:
      position: 104
      prefix: -extraIndex=
      itemSeparator: ','
      separate: false
  - id: sizes_is_2bit
    type:
      - 'null'
      - boolean
    doc: If set, the chrom.sizes file is assumed to be a 2bit file.
    inputBinding:
      position: 104
      prefix: -sizesIs2Bit
  - id: sizes_is_chrom_alias_bb
    type:
      - 'null'
      - boolean
    doc: If set, then chrom.sizes file is assumed to be a chromAlias bigBed file
      or a URL to a such a file.
    inputBinding:
      position: 104
      prefix: -sizesIsChromAliasBb
  - id: sizes_is_bb
    type:
      - 'null'
      - boolean
    doc: Obsolete name for -sizesIsChromAliasBb.
    inputBinding:
      position: 104
      prefix: -sizesIsBb
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: sets the UDC cache dir for caching of remote files.
    inputBinding:
      position: 104
      prefix: -udcDir=
      separate: false
  - id: allow_1bp_overlap
    type:
      - 'null'
      - boolean
    doc: allow exons to overlap by at most one base pair
    inputBinding:
      position: 104
      prefix: -allow1bpOverlap
  - id: max_alloc
    type:
      - 'null'
      - int
    doc: Set the maximum memory allocation size to N bytes
    inputBinding:
      position: 104
      prefix: -maxAlloc=
      separate: false
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort the input file
    inputBinding:
      position: 104
      prefix: -sort
outputs:
  - id: out_out_bb
    type: File
    doc: out.bb is the output indexed big bed file
    outputBinding:
      glob: $(inputs.out_bb)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtobigbed:482--hdc0a859_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
