cwlVersion: v1.2
class: CommandLineTool
label: samtools_markdup
doc: |-
  Mark duplicate alignments from a coordinate-sorted file that has gone through fixmates. The input file must be coordinate sorted and must have gone through fixmates with the mate scoring option on.

  Tool homepage: https://github.com/samtools/samtools
requirements:
- class: InlineJavascriptRequirement
baseCommand:
- samtools
- markdup
inputs:
- id: input_bam
  type: File
  doc: Input BAM file
  inputBinding:
    position: 1
- id: output_filename
  type: string
  doc: Name of the output BAM file
  inputBinding:
    position: 2
- id: barcode_name
  type: boolean?
  doc: Use the UMI/barcode in the read name (eigth colon delimited part).
  inputBinding:
    position: 102
    prefix: --barcode-name
- id: barcode_rgx
  type: string?
  doc: Regex for barcode in the readname (alternative to --barcode-name).
  inputBinding:
    position: 102
    prefix: --barcode-rgx
- id: barcode_tag
  type: string?
  doc: Use barcode a tag that duplicates much match.
  inputBinding:
    position: 102
    prefix: --barcode-tag
- id: clear_tags
  type: boolean?
  doc: Clear previous duplicate settings and tags.
  inputBinding:
    position: 102
    prefix: -c
- id: coords_order
  type: string?
  doc: Order of regex elements. txy (default). With t being a part of the read 
    names that must be equal and x/y being coordinates.
  inputBinding:
    position: 102
    prefix: --coords-order
- id: duplicate_count
  type: boolean?
  doc: Record the original primary read duplication count(include itself) in a 
    'dc' tag.
  inputBinding:
    position: 102
    prefix: --duplicate-count
- id: include_fails
  type: boolean?
  doc: Include quality check failed reads.
  inputBinding:
    position: 102
    prefix: --include-fails
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: json_stats
  type: boolean?
  doc: Output stats in JSON. Also implies -s
  inputBinding:
    position: 102
    prefix: --json
- id: mark_primary_duplicates
  type: boolean?
  doc: Mark primary duplicates with the name of the original in a 'do' tag. 
    Mainly for information and debugging.
  inputBinding:
    position: 102
    prefix: -t
- id: mark_supplementary
  type: boolean?
  doc: Mark supplementary alignments of duplicates as duplicates (slower).
  inputBinding:
    position: 102
    prefix: -S
- id: max_read_length
  type: int?
  doc: Max read length
  inputBinding:
    position: 102
    prefix: -l
- id: mode
  type: string?
  doc: Duplicate decision method for paired reads. TYPE = t measure positions 
    based on template start/end (default); s measure positions based on sequence
    start.
  inputBinding:
    position: 102
    prefix: --mode
- id: no_multi_dup
  type: boolean?
  doc: Reduced duplicates of duplicates checking.
  inputBinding:
    position: 102
    prefix: --no-multi-dup
- id: no_pg
  type: boolean?
  doc: Do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: optical_distance
  type: int?
  doc: Optical distance (if set, marks with dt tag)
  inputBinding:
    position: 102
    prefix: -d
- id: output_fmt
  type: string?
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 102
    prefix: --output-fmt
- id: output_fmt_option
  type: string[]?
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: read_coords
  type: string?
  doc: Regex for coords from read name.
  inputBinding:
    position: 102
    prefix: --read-coords
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE [null]
  inputBinding:
    position: 102
    prefix: --reference
- id: remove_duplicates
  type: boolean?
  doc: Remove duplicate reads
  inputBinding:
    position: 102
    prefix: -r
- id: report_stats
  type: boolean?
  doc: Report stats.
  inputBinding:
    position: 102
    prefix: -s
- id: stats_filename
  type: string?
  doc: Write stats to named file. Implies -s.
  inputBinding:
    position: 102
    prefix: -f
- id: temp_prefix
  type: string?
  doc: Write temporary files to PREFIX.samtools.nnnn.nnnn.tmp.
  inputBinding:
    position: 102
    prefix: -T
- id: threads
  type: int?
  doc: Number of additional threads to use
  inputBinding:
    position: 102
    prefix: --threads
- id: uncompressed_output
  type: boolean?
  doc: Output uncompressed data
  inputBinding:
    position: 102
    prefix: -u
- id: use_read_groups
  type: boolean?
  doc: Use the read group tags in duplicate matching.
  inputBinding:
    position: 102
    prefix: --use-read-groups
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: write_index
  type: boolean?
  doc: Automatically index the output files [off]
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_bam
  type: File
  doc: Output BAM file
  outputBinding:
    glob: $(inputs.output_filename)
- id: stats_file
  type: File?
  doc: Write stats to named file. Implies -s.
  outputBinding:
    glob: $(inputs.stats_filename)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
