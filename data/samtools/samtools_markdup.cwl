cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - markdup
label: samtools_markdup
doc: Mark duplicate alignments in a coordinate-sorted BAM file
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: output_bam
    type: string
    doc: Output BAM file
    inputBinding:
      position: 2
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicate reads
    inputBinding:
      position: 103
      prefix: -r
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Max read length (default 300 bases)
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
    doc: Write stats to named file. Implies -s.
    inputBinding:
      position: 103
      prefix: -f
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output stats in JSON. Also implies -s
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
    doc: Optical distance (if set, marks with dt tag)
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
    doc: Duplicate decision method for paired reads. TYPE = t measure positions 
      based on template start/end (default). s measure positions based on 
      sequence start.
    inputBinding:
      position: 103
      prefix: --mode
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Output uncompressed data
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
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: Do not add a PG line
    inputBinding:
      position: 103
      prefix: --no-PG
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
    doc: Order of regex elements. txy (default). With t being a part of the read
      names that must be equal and x/y being coordinates.
    inputBinding:
      position: 103
      prefix: --coords-order
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Use barcode a tag that duplicates much match.
    inputBinding:
      position: 103
      prefix: --barcode-tag
  - id: barcode_name
    type:
      - 'null'
      - boolean
    doc: Use the UMI/barcode in the read name (eigth colon delimited part).
    inputBinding:
      position: 103
      prefix: --barcode-name
  - id: barcode_rgx
    type:
      - 'null'
      - string
    doc: Regex for barcode in the readname (alternative to --barcode-name).
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
    doc: Mark primary duplicates with the name of the original in a 'do' tag. 
      Mainly for information and debugging.
    inputBinding:
      position: 103
      prefix: -t
  - id: duplicate_count
    type:
      - 'null'
      - boolean
    doc: Record the original primary read duplication count(include itself) in a
      'dc' tag.
    inputBinding:
      position: 103
      prefix: --duplicate-count
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 103
      prefix: --output-fmt
  - id: output_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --output-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 103
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    inputBinding:
      position: 103
      prefix: --threads
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Automatically index the output files [off]
    inputBinding:
      position: 103
      prefix: --write-index
outputs:
  - id: out_output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
  - id: output_stats_file
    type:
      - 'null'
      - File
    doc: Write stats to named file. Implies -s.
    outputBinding:
      glob: $(inputs.stats_file)
  - id: output_temp_prefix
    type:
      - 'null'
      - File[]
    doc: Write temporary files to PREFIX.samtools.nnnn.nnnn.tmp.
    outputBinding:
      glob: $(inputs.temp_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
