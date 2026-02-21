cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - markdup
label: samtools_markdup
doc: "Mark duplicate alignments from a coordinate-sorted file that has gone through
  fixmates. The input file must be coordinate sorted and must have gone through fixmates
  with the mate scoring option on.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: barcode_name
    type:
      - 'null'
      - boolean
    doc: Use the UMI/barcode in the read name (eigth colon delimited part).
    inputBinding:
      position: 102
      prefix: --barcode-name
  - id: barcode_rgx
    type:
      - 'null'
      - string
    doc: Regex for barcode in the readname (alternative to --barcode-name).
    inputBinding:
      position: 102
      prefix: --barcode-rgx
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Use barcode a tag that duplicates much match.
    inputBinding:
      position: 102
      prefix: --barcode-tag
  - id: clear_tags
    type:
      - 'null'
      - boolean
    doc: Clear previous duplicate settings and tags.
    inputBinding:
      position: 102
      prefix: -c
  - id: coords_order
    type:
      - 'null'
      - string
    doc: Order of regex elements. txy (default). With t being a part of the read
      names that must be equal and x/y being coordinates.
    default: txy
    inputBinding:
      position: 102
      prefix: --coords-order
  - id: duplicate_count
    type:
      - 'null'
      - boolean
    doc: Record the original primary read duplication count(include itself) in a
      'dc' tag.
    inputBinding:
      position: 102
      prefix: --duplicate-count
  - id: include_fails
    type:
      - 'null'
      - boolean
    doc: Include quality check failed reads.
    inputBinding:
      position: 102
      prefix: --include-fails
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: json_stats
    type:
      - 'null'
      - boolean
    doc: Output stats in JSON. Also implies -s
    inputBinding:
      position: 102
      prefix: --json
  - id: mark_primary_duplicates
    type:
      - 'null'
      - boolean
    doc: Mark primary duplicates with the name of the original in a 'do' tag. 
      Mainly for information and debugging.
    inputBinding:
      position: 102
      prefix: -t
  - id: mark_supplementary
    type:
      - 'null'
      - boolean
    doc: Mark supplementary alignments of duplicates as duplicates (slower).
    inputBinding:
      position: 102
      prefix: -S
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length
    default: 300
    inputBinding:
      position: 102
      prefix: -l
  - id: mode
    type:
      - 'null'
      - string
    doc: Duplicate decision method for paired reads. TYPE = t measure positions 
      based on template start/end (default); s measure positions based on 
      sequence start.
    default: t
    inputBinding:
      position: 102
      prefix: --mode
  - id: no_multi_dup
    type:
      - 'null'
      - boolean
    doc: Reduced duplicates of duplicates checking.
    inputBinding:
      position: 102
      prefix: --no-multi-dup
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: Do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: optical_distance
    type:
      - 'null'
      - int
    doc: Optical distance (if set, marks with dt tag)
    inputBinding:
      position: 102
      prefix: -d
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: output_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --output-fmt-option
  - id: read_coords
    type:
      - 'null'
      - string
    doc: Regex for coords from read name.
    inputBinding:
      position: 102
      prefix: --read-coords
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    inputBinding:
      position: 102
      prefix: --reference
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicate reads
    inputBinding:
      position: 102
      prefix: -r
  - id: report_stats
    type:
      - 'null'
      - boolean
    doc: Report stats.
    inputBinding:
      position: 102
      prefix: -s
  - id: temp_prefix
    type:
      - 'null'
      - string
    doc: Write temporary files to PREFIX.samtools.nnnn.nnnn.tmp.
    inputBinding:
      position: 102
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: uncompressed_output
    type:
      - 'null'
      - boolean
    doc: Output uncompressed data
    inputBinding:
      position: 102
      prefix: -u
  - id: use_read_groups
    type:
      - 'null'
      - boolean
    doc: Use the read group tags in duplicate matching.
    inputBinding:
      position: 102
      prefix: --use-read-groups
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Automatically index the output files [off]
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: '*.out'
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Write stats to named file. Implies -s.
    outputBinding:
      glob: $(inputs.stats_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
