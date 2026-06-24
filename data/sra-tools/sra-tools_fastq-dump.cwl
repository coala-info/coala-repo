cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-dump
label: sra-tools_fastq-dump
doc: Dump data from SRA (Sequence Read Archive) into FASTQ format
inputs:
  - id: input_path
    type:
      type: array
      items: string
    doc: Path to SRA data or accession number
    inputBinding:
      position: 1
  - id: accession
    type:
      - 'null'
      - string
    doc: Replaces accession derived from <path> in filename(s) and deflines 
      (only for single table dump)
    inputBinding:
      position: 102
      prefix: --accession
  - id: table
    type:
      - 'null'
      - string
    doc: Table name within cSRA object
    inputBinding:
      position: 102
      prefix: --table
  - id: split_spot
    type:
      - 'null'
      - boolean
    doc: Split spots into individual reads
    inputBinding:
      position: 102
      prefix: --split-spot
  - id: min_spot_id
    type:
      - 'null'
      - int
    doc: Minimum spot id
    inputBinding:
      position: 102
      prefix: --minSpotId
  - id: max_spot_id
    type:
      - 'null'
      - int
    doc: Maximum spot id
    inputBinding:
      position: 102
      prefix: --maxSpotId
  - id: spot_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter by SPOT_GROUP (member): name[,...]'
    inputBinding:
      position: 102
      prefix: --spot-groups
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Remove adapter sequences from reads
    inputBinding:
      position: 102
      prefix: --clip
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Filter by sequence length >= <len>
    inputBinding:
      position: 102
      prefix: --minReadLen
  - id: read_filter
    type:
      - 'null'
      - string
    doc: 'Split into files by READ_FILTER value optionally filter by value: pass|reject|criteria|redacted'
    inputBinding:
      position: 102
      prefix: --read-filter
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
  - id: aligned
    type:
      - 'null'
      - boolean
    doc: Dump only aligned sequences
    inputBinding:
      position: 102
      prefix: --aligned
  - id: unaligned
    type:
      - 'null'
      - boolean
    doc: Dump only unaligned sequences
    inputBinding:
      position: 102
      prefix: --unaligned
  - id: aligned_region
    type:
      - 'null'
      - string
    doc: Filter by position on genome. Name can either be accession.version or 
      file specific name. 'from' and 'to' are 1-based coordinates
    inputBinding:
      position: 102
      prefix: --aligned-region
  - id: matepair_distance
    type:
      - 'null'
      - string
    doc: Filter by distance between matepairs. Use 'unknown' to find matepairs 
      split between the references. Use from-to to limit matepair distance on 
      the same reference
    inputBinding:
      position: 102
      prefix: --matepair-distance
  - id: skip_technical
    type:
      - 'null'
      - boolean
    doc: Dump only biological reads
    inputBinding:
      position: 102
      prefix: --skip-technical
  - id: outdir
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout, all split data become joined into single stream
    inputBinding:
      position: 102
      prefix: --stdout
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: 'Compress output using gzip: deprecated, not recommended'
    inputBinding:
      position: 102
      prefix: --gzip
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: 'Compress output using bzip2: deprecated, not recommended'
    inputBinding:
      position: 102
      prefix: --bzip2
  - id: split_files
    type:
      - 'null'
      - boolean
    doc: Write reads into separate files. Read number will be suffixed to the 
      file name.
    inputBinding:
      position: 102
      prefix: --split-files
  - id: split_3
    type:
      - 'null'
      - boolean
    doc: 3-way splitting for mate-pairs. Recommended over --split-files.
    inputBinding:
      position: 102
      prefix: --split-3
  - id: split_spot_group
    type:
      - 'null'
      - boolean
    doc: Split into files by SPOT_GROUP (member name)
    inputBinding:
      position: 102
      prefix: --spot-group
  - id: group_in_dirs
    type:
      - 'null'
      - boolean
    doc: Split into subdirectories instead of files
    inputBinding:
      position: 102
      prefix: --group-in-dirs
  - id: keep_empty_files
    type:
      - 'null'
      - boolean
    doc: Do not delete empty files
    inputBinding:
      position: 102
      prefix: --keep-empty-files
  - id: dumpcs
    type:
      - 'null'
      - string
    doc: Formats sequence using color space (default for SOLiD), 'cskey' may be 
      specified for translation
    inputBinding:
      position: 102
      prefix: --dumpcs
  - id: dumpbase
    type:
      - 'null'
      - boolean
    doc: Formats sequence using base space (default for other than SOLiD).
    inputBinding:
      position: 102
      prefix: --dumpbase
  - id: offset
    type:
      - 'null'
      - int
    doc: Offset to use for quality conversion
    inputBinding:
      position: 102
      prefix: --offset
  - id: fasta
    type:
      - 'null'
      - int
    doc: FASTA only, no qualities, optional line wrap width (set to zero for no 
      wrapping)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: suppress_qual_for_cskey
    type:
      - 'null'
      - boolean
    doc: suppress quality-value for cskey
    inputBinding:
      position: 102
      prefix: --suppress-qual-for-cskey
  - id: origfmt
    type:
      - 'null'
      - boolean
    doc: Defline contains only original sequence name
    inputBinding:
      position: 102
      prefix: --origfmt
  - id: readids
    type:
      - 'null'
      - boolean
    doc: Append read id after spot id as 'accession.spot.readid' on defline
    inputBinding:
      position: 102
      prefix: --readids
  - id: helicos
    type:
      - 'null'
      - boolean
    doc: Helicos style defline
    inputBinding:
      position: 102
      prefix: --helicos
  - id: defline_seq
    type:
      - 'null'
      - string
    doc: Defline format specification for sequence.
    inputBinding:
      position: 102
      prefix: --defline-seq
  - id: defline_qual
    type:
      - 'null'
      - string
    doc: Defline format specification for quality.
    inputBinding:
      position: 102
      prefix: --defline-qual
  - id: ngc
    type:
      - 'null'
      - File
    doc: Path to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: disable_multithreading
    type:
      - 'null'
      - boolean
    doc: disable multithreading
    inputBinding:
      position: 102
      prefix: --disable-multithreading
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string
    inputBinding:
      position: 102
      prefix: --log-level
  - id: ncbi_error_report
    type:
      - 'null'
      - string
    doc: Control program execution environment report generation
    inputBinding:
      position: 102
      prefix: --ncbi_error_report
  - id: legacy_report
    type:
      - 'null'
      - boolean
    doc: use legacy style 'Written spots' for tool
    inputBinding:
      position: 102
      prefix: --legacy-report
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
s:url: https://github.com/ncbi/sra-tools
$namespaces:
  s: https://schema.org/
