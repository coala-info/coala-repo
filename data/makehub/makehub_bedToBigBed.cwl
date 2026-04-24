cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToBigBed
label: makehub_bedToBigBed
doc: "Convert bed file to bigBed.\n\nTool homepage: https://github.com/Gaius-Augustus/MakeHub"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file in one of the ascii bed formats, but not including track
      lines
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'A two-column file/URL: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: allow_1bp_overlap
    type:
      - 'null'
      - boolean
    doc: allow exons to overlap by at most one base pair
    inputBinding:
      position: 103
  - id: as
    type:
      - 'null'
      - File
    doc: If you have non-standard "bedPlus" fields, it's great to put a 
      definition of each field in a row in AutoSql format here.
    inputBinding:
      position: 103
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree.
    inputBinding:
      position: 103
  - id: extra_index
    type:
      - 'null'
      - string
    doc: If set, make an index on each field in a comma separated list. 
      extraIndex=name and extraIndex=name,id are commonly used.
    inputBinding:
      position: 103
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level.
    inputBinding:
      position: 103
  - id: max_alloc
    type:
      - 'null'
      - int
    doc: Set the maximum memory allocation size to N bytes
    inputBinding:
      position: 103
  - id: sizes_is_2bit
    type:
      - 'null'
      - boolean
    doc: If set, the chrom.sizes file is assumed to be a 2bit file.
    inputBinding:
      position: 103
  - id: sizes_is_bb
    type:
      - 'null'
      - boolean
    doc: Obsolete name for -sizesIsChromAliasBb.
    inputBinding:
      position: 103
  - id: sizes_is_chrom_alias_bb
    type:
      - 'null'
      - boolean
    doc: If set, then chrom.sizes file is assumed to be a chromAlias bigBed file
      or a URL to a such a file
    inputBinding:
      position: 103
  - id: tab
    type:
      - 'null'
      - boolean
    doc: If set, expect fields to be tab separated, normally expects white space
      separator.
    inputBinding:
      position: 103
  - id: type
    type:
      - 'null'
      - string
    doc: 'N is between 3 and 15, optional (+) if extra "bedPlus" fields, optional
      P specifies the number of extra fields. Not required, but preferred. Examples:
      -type=bed6 or -type=bed6+ or -type=bed6+3'
    inputBinding:
      position: 103
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: sets the UDC cache dir for caching of remote files.
    inputBinding:
      position: 103
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression.
    inputBinding:
      position: 103
outputs:
  - id: output_bigbed
    type: File
    doc: The output indexed big bed file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/makehub:1.0.8--hdfd78af_1
