cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-dump
label: parallel-fastq-dump_fastq-dump
doc: "Dump SRA data into FASTQ format\n\nTool homepage: https://github.com/rvalieris/parallel-fastq-dump"
inputs:
  - id: accessions
    type:
      type: array
      items: string
    doc: list of accessions to process
    inputBinding:
      position: 1
  - id: accession
    type:
      - 'null'
      - string
    doc: Replaces accession derived from <path> in filename(s) and deflines (only
      for single table dump)
    inputBinding:
      position: 102
      prefix: --accession
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: Dump only aligned sequences
    inputBinding:
      position: 102
      prefix: --aligned
  - id: aligned_region
    type:
      - 'null'
      - string
    doc: Filter by position on genome. Name can eiter by accession.version or file
      specific name. from and to are 1-based coordinates
    inputBinding:
      position: 102
      prefix: --aligned-region
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: 'Compress output using bzip2: deprecated, not recommended'
    inputBinding:
      position: 102
      prefix: --bzip2
  - id: cart
    type:
      - 'null'
      - File
    doc: path to cart file
    inputBinding:
      position: 102
      prefix: --cart
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Remove adapter sequences from reads
    inputBinding:
      position: 102
      prefix: --clip
  - id: defline_qual
    type:
      - 'null'
      - string
    doc: Defline format specification for quality.
    inputBinding:
      position: 102
      prefix: --defline-qual
  - id: defline_seq
    type:
      - 'null'
      - string
    doc: Defline format specification for sequence.
    inputBinding:
      position: 102
      prefix: --defline-seq
  - id: disable_multithreading
    type:
      - 'null'
      - boolean
    doc: disable multithreading
    inputBinding:
      position: 102
      prefix: --disable-multithreading
  - id: dumpbase
    type:
      - 'null'
      - boolean
    doc: Formats sequence using base space (default for other than SOLiD).
    inputBinding:
      position: 102
      prefix: --dumpbase
  - id: dumpcs
    type:
      - 'null'
      - string
    doc: Formats sequence using color space (default for SOLiD), 'cskey' may be specified
      for translation or else specify 'dflt' to use the default value
    inputBinding:
      position: 102
      prefix: --dumpcs
  - id: fasta
    type:
      - 'null'
      - string
    doc: FASTA only, no qualities, with can be 'default' or '0' for no wrapping
    inputBinding:
      position: 102
      prefix: --fasta
  - id: group_in_dirs
    type:
      - 'null'
      - boolean
    doc: Split into subdirectories instead of files
    inputBinding:
      position: 102
      prefix: --group-in-dirs
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'Compress output using gzip: deprecated, not recommended'
    inputBinding:
      position: 102
      prefix: --gzip
  - id: helicos
    type:
      - 'null'
      - boolean
    doc: Helicos style defline
    inputBinding:
      position: 102
      prefix: --helicos
  - id: keep_empty_files
    type:
      - 'null'
      - boolean
    doc: Do not delete empty files
    inputBinding:
      position: 102
      prefix: --keep-empty-files
  - id: location
    type:
      - 'null'
      - string
    doc: location in cloud
    inputBinding:
      position: 102
      prefix: --location
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of (fatal|sys|int|err|warn|info|debug)
      or (0-6)
    default: warn
    inputBinding:
      position: 102
      prefix: --log-level
  - id: matepair_distance
    type:
      - 'null'
      - string
    doc: Filter by distance between matepairs. Use 'unknown' to find matepairs split
      between the references. Use from-to to limit matepair distance on the same reference
    inputBinding:
      position: 102
      prefix: --matepair_distance
  - id: max_spot_id
    type:
      - 'null'
      - int
    doc: Maximum spot id
    inputBinding:
      position: 102
      prefix: --maxSpotId
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Filter by sequence length >= <len>
    inputBinding:
      position: 102
      prefix: --minReadLen
  - id: min_spot_id
    type:
      - 'null'
      - int
    doc: Minimum spot id
    inputBinding:
      position: 102
      prefix: --minSpotId
  - id: ngc
    type:
      - 'null'
      - File
    doc: path to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: offset
    type:
      - 'null'
      - int
    doc: Offset to use for quality conversion
    default: 33
    inputBinding:
      position: 102
      prefix: --offset
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
  - id: origfmt
    type:
      - 'null'
      - boolean
    doc: Defline contains only original sequence name
    inputBinding:
      position: 102
      prefix: --origfmt
  - id: perm
    type:
      - 'null'
      - File
    doc: path to permission file
    inputBinding:
      position: 102
      prefix: --perm
  - id: qual_filter
    type:
      - 'null'
      - boolean
    doc: 'Filter used in early 1000 Genomes data: no sequences starting or ending
      with >= 10N'
    inputBinding:
      position: 102
      prefix: --qual-filter
  - id: qual_filter_1
    type:
      - 'null'
      - boolean
    doc: Filter used in current 1000 Genomes data
    inputBinding:
      position: 102
      prefix: --qual-filter-1
  - id: read_filter
    type:
      - 'null'
      - string
    doc: 'Split into files by READ_FILTER value [split], optionally filter by value:
      [pass|reject|criteria|redacted]'
    inputBinding:
      position: 102
      prefix: --read-filter
  - id: readids
    type:
      - 'null'
      - boolean
    doc: Append read id after spot id as 'accession.spot.readid' on defline
    inputBinding:
      position: 102
      prefix: --readids
  - id: skip_technical
    type:
      - 'null'
      - boolean
    doc: Dump only biological reads
    inputBinding:
      position: 102
      prefix: --skip-technical
  - id: split_3
    type:
      - 'null'
      - boolean
    doc: 3-way splitting for mate-pairs.
    inputBinding:
      position: 102
      prefix: --split-3
  - id: split_files
    type:
      - 'null'
      - boolean
    doc: Write reads into separate files. Read number will be suffixed to the file
      name.
    inputBinding:
      position: 102
      prefix: --split-files
  - id: split_spot
    type:
      - 'null'
      - boolean
    doc: Split spots into individual reads
    inputBinding:
      position: 102
      prefix: --split-spot
  - id: spot_group_split
    type:
      - 'null'
      - boolean
    doc: Split into files by SPOT_GROUP (member name)
    inputBinding:
      position: 102
      prefix: --spot-group
  - id: spot_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter by SPOT_GROUP (member): name[,...]'
    inputBinding:
      position: 102
      prefix: --spot-groups
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout, all split data become joined into single stream
    inputBinding:
      position: 102
      prefix: --stdout
  - id: suppress_qual_for_cskey
    type:
      - 'null'
      - boolean
    doc: suppress quality-value for cskey
    inputBinding:
      position: 102
      prefix: --suppress-qual-for-cskey
  - id: table
    type:
      - 'null'
      - string
    doc: Table name within cSRA object
    default: SEQUENCE
    inputBinding:
      position: 102
      prefix: --table
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: Dump only unaligned sequences
    inputBinding:
      position: 102
      prefix: --unaligned
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase the verbosity of the program status messages. Use multiple times
      for more verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
