cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- markdup
label: samtools_markdup
doc: 'Mark duplicate alignments in a coordinate sorted file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Coordinate-sorted input file that has been through fixmate -m.
  inputBinding:
    position: 104
- id: output_filename
  type: string
  doc: Name of the output file.
  default: markdup.bam
  inputBinding:
    position: 105
- id: remove_duplicates
  type:
  - 'null'
  - boolean
  doc: Remove duplicate reads.
  inputBinding:
    position: 103
    prefix: -r
- id: max_read_length
  type:
  - 'null'
  - int
  doc: Max read length (default 300 bases).
  inputBinding:
    position: 103
    prefix: -l
- id: mark_supplementary
  type:
  - 'null'
  - boolean
  doc: Mark supplementary alignments of duplicates as duplicates (slower).
  inputBinding:
    position: 103
    prefix: -S
- id: report_stats
  type:
  - 'null'
  - boolean
  doc: Report stats.
  inputBinding:
    position: 103
    prefix: -s
- id: stats_file
  type:
  - 'null'
  - string
  doc: Write stats to named file (implies -s).
  inputBinding:
    position: 103
    prefix: -f
- id: json
  type:
  - 'null'
  - boolean
  doc: Output stats in JSON (also implies -s).
  inputBinding:
    position: 103
    prefix: --json
- id: temp_prefix
  type:
  - 'null'
  - string
  doc: Write temporary files to PREFIX.samtools.nnnn.nnnn.tmp.
  inputBinding:
    position: 103
    prefix: -T
- id: optical_distance
  type:
  - 'null'
  - int
  doc: Optical distance (if set, marks with dt tag).
  inputBinding:
    position: 103
    prefix: -d
- id: clear_tags
  type:
  - 'null'
  - boolean
  doc: Clear previous duplicate settings and tags.
  inputBinding:
    position: 103
    prefix: -c
- id: mode
  type:
  - 'null'
  - string
  doc: 'Duplicate decision method for paired reads: t (template start/end, default) or s (sequence start).'
  inputBinding:
    position: 103
    prefix: --mode
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Output uncompressed data.
  inputBinding:
    position: 103
    prefix: -u
- id: include_fails
  type:
  - 'null'
  - boolean
  doc: Include quality check failed reads.
  inputBinding:
    position: 103
    prefix: --include-fails
- id: no_multi_dup
  type:
  - 'null'
  - boolean
  doc: Reduced duplicates of duplicates checking.
  inputBinding:
    position: 103
    prefix: --no-multi-dup
- id: read_coords
  type:
  - 'null'
  - string
  doc: Regex for coords from read name.
  inputBinding:
    position: 103
    prefix: --read-coords
- id: coords_order
  type:
  - 'null'
  - string
  doc: Order of regex elements; txy (default).
  inputBinding:
    position: 103
    prefix: --coords-order
- id: barcode_tag
  type:
  - 'null'
  - string
  doc: Use barcode a tag that duplicates must match.
  inputBinding:
    position: 103
    prefix: --barcode-tag
- id: barcode_name
  type:
  - 'null'
  - boolean
  doc: Use the UMI/barcode in the read name (eighth colon delimited part).
  inputBinding:
    position: 103
    prefix: --barcode-name
- id: barcode_rgx
  type:
  - 'null'
  - string
  doc: Regex for barcode in the read name (alternative to --barcode-name).
  inputBinding:
    position: 103
    prefix: --barcode-rgx
- id: use_read_groups
  type:
  - 'null'
  - boolean
  doc: Use the read group tags in duplicate matching.
  inputBinding:
    position: 103
    prefix: --use-read-groups
- id: mark_primary_duplicates
  type:
  - 'null'
  - boolean
  doc: Mark primary duplicates with the name of the original in a do tag.
  inputBinding:
    position: 103
    prefix: -t
- id: duplicate_count
  type:
  - 'null'
  - boolean
  doc: Record the original primary read duplication count (including itself) in a dc tag.
  inputBinding:
    position: 103
    prefix: --duplicate-count
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Specify output format (SAM, BAM, CRAM) and optional format options, e.g. bam,level=1.
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file (needed for CRAM).
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use.
  inputBinding:
    position: 103
    prefix: --threads
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output file.
  inputBinding:
    position: 103
    prefix: --write-index
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line to the header.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
outputs:
- id: output
  type: File
  doc: BAM with duplicates marked.
  outputBinding:
    glob: $(inputs.output_filename)
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the output when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).bai
    - $(inputs.output_filename).csi
    - $(inputs.output_filename).crai
- id: stats_output
  type:
  - 'null'
  - File
  doc: Duplicate statistics written with -f.
  outputBinding:
    glob: $(inputs.stats_file)
