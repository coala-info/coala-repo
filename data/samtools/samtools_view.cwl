cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- view
label: samtools_view
doc: "View and convert SAM/BAM/CRAM files\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input BAM/SAM/CRAM file
  inputBinding:
    position: 104
- id: regions
  type:
  - 'null'
  - type: array
    items: string
  doc: Region(s) to extract
  inputBinding:
    position: 105
- id: add_flags
  type:
  - 'null'
  - string
  doc: Add FLAGs to reads
  inputBinding:
    position: 103
    prefix: --add-flags
- id: bam
  type:
  - 'null'
  - boolean
  doc: Output BAM
  inputBinding:
    position: 103
    prefix: --bam
- id: count
  type:
  - 'null'
  - boolean
  doc: Print only the count of matching records
  inputBinding:
    position: 103
    prefix: --count
- id: cram
  type:
  - 'null'
  - boolean
  doc: Output CRAM (requires -T)
  inputBinding:
    position: 103
    prefix: --cram
- id: customized_index
  type:
  - 'null'
  - boolean
  doc: Expect extra index file argument after <in.bam>
  inputBinding:
    position: 103
    prefix: --customized-index
- id: exclude_all_flags
  type:
  - 'null'
  - string
  doc: EXCLUDE reads with all of the FLAGs present
  inputBinding:
    position: 103
    prefix: -G
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have none of the FLAGs present
  inputBinding:
    position: 103
    prefix: --exclude-flags
- id: exclude_no_read_group
  type:
  - 'null'
  - boolean
  doc: Only include reads that have a read group, exclude those that have not
  inputBinding:
    position: 103
    prefix: --exclude-no-read_group
- id: expr
  type:
  - 'null'
  - string
  doc: Only include reads that match the filter expression STR
  inputBinding:
    position: 103
    prefix: --expr
- id: fai_reference
  type:
  - 'null'
  - File
  doc: FILE listing reference names and lengths
  inputBinding:
    position: 103
    prefix: --fai-reference
- id: fast
  type:
  - 'null'
  - boolean
  doc: Use fast BAM compression (and default to --bam)
  inputBinding:
    position: 103
    prefix: --fast
- id: fetch_pairs
  type:
  - 'null'
  - boolean
  doc: Retrieve complete pairs even when outside of region
  inputBinding:
    position: 103
    prefix: --fetch-pairs
- id: header_only
  type:
  - 'null'
  - boolean
  doc: Print SAM header only (no alignments)
  inputBinding:
    position: 103
    prefix: --header-only
- id: include_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have some of the FLAGs present
  inputBinding:
    position: 103
    prefix: --include-flags
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify a single input file format option
  inputBinding:
    position: 103
    prefix: --input-fmt-option
- id: keep_tag
  type:
  - 'null'
  - type: array
    items: string
  doc: Comma-separated read tags to preserve (repeatable)
  inputBinding:
    position: 103
    prefix: --keep-tag
- id: library
  type:
  - 'null'
  - string
  doc: Only include reads in library STR
  inputBinding:
    position: 103
    prefix: --library
- id: min_mq
  type:
  - 'null'
  - int
  doc: Only include reads that have mapping quality >= INT
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: min_qlen
  type:
  - 'null'
  - int
  doc: Only include reads that cover >= INT query bases
  inputBinding:
    position: 103
    prefix: --min-qlen
- id: no_header
  type:
  - 'null'
  - boolean
  doc: Print SAM alignment records only [default]
  inputBinding:
    position: 103
    prefix: --no-header
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line
  inputBinding:
    position: 103
    prefix: --no-PG
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
  - type: array
    items: string
  doc: Specify a single output file format option
  inputBinding:
    position: 103
    prefix: --output-fmt-option
- id: qname_file
  type:
  - 'null'
  - File
  doc: Only include reads whose read name is listed in FILE
  inputBinding:
    position: 103
    prefix: --qname-file
- id: read_group
  type:
  - 'null'
  - string
  doc: Only include reads in read group STR or in no read group
  inputBinding:
    position: 103
    prefix: --read-group
- id: read_group_file
  type:
  - 'null'
  - File
  doc: Only include reads in a read group listed in FILE or in none
  inputBinding:
    position: 103
    prefix: --read-group-file
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 103
    prefix: --reference
- id: regions_file
  type:
  - 'null'
  - File
  doc: Use index to include only reads overlapping FILE
  inputBinding:
    position: 103
    prefix: --regions-file
- id: remove_b
  type:
  - 'null'
  - boolean
  doc: Collapse the backward CIGAR operation
  inputBinding:
    position: 103
    prefix: --remove-B
- id: remove_flags
  type:
  - 'null'
  - string
  doc: Remove FLAGs from reads
  inputBinding:
    position: 103
    prefix: --remove-flags
- id: remove_tag
  type:
  - 'null'
  - type: array
    items: string
  doc: Comma-separated read tags to strip (repeatable)
  inputBinding:
    position: 103
    prefix: --remove-tag
- id: require_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have all of the FLAGs present
  inputBinding:
    position: 103
    prefix: --require-flags
- id: sanitize
  type:
  - 'null'
  - string
  doc: Perform sanitity checking and fixing on records.
  inputBinding:
    position: 103
    prefix: --sanitize
- id: subsample
  type:
  - 'null'
  - float
  doc: Keep only FLOAT fraction of templates/read pairs
  inputBinding:
    position: 103
    prefix: --subsample
- id: subsample_seed
  type:
  - 'null'
  - int
  doc: Influence WHICH reads are kept in subsampling
  default: 0
  inputBinding:
    position: 103
    prefix: --subsample-seed
- id: tag
  type:
  - 'null'
  - string
  doc: Only include reads that have a tag STR1 (with associated value STR2)
  inputBinding:
    position: 103
    prefix: --tag
- id: tag_file
  type:
  - 'null'
  - string
  doc: Only include reads that have a tag STR whose value is listed in FILE
  inputBinding:
    position: 103
    prefix: --tag-file
- id: targets_file
  type:
  - 'null'
  - File
  doc: Only include reads that overlap (BED) regions in FILE
  inputBinding:
    position: 103
    prefix: --target-file
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  default: 0
  inputBinding:
    position: 103
    prefix: --threads
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output (and default to --bam)
  inputBinding:
    position: 103
    prefix: --uncompressed
- id: unmap
  type:
  - 'null'
  - boolean
  doc: Set flag to UNMAP on reads not selected then write to output file.
  inputBinding:
    position: 103
    prefix: --unmap
- id: use_index
  type:
  - 'null'
  - boolean
  doc: Use index and multi-region iterator for regions
  inputBinding:
    position: 103
    prefix: --use-index
- id: with_header
  type:
  - 'null'
  - boolean
  doc: Include the header in the output
  inputBinding:
    position: 103
    prefix: --with-header
- id: output_filename
  type: string?
  doc: Output filename
  inputBinding:
    position: 103
    prefix: -o
outputs:
- id: output
  type: File
  outputBinding:
    glob: $(inputs.output_filename || 'output.sam')
stdout: $(inputs.output_filename || 'output.sam')
