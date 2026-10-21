cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- view
label: samtools_view
doc: 'View and convert SAM/BAM/CRAM files


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file.
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: regions
  type:
  - 'null'
  - type: array
    items: string
  doc: Region(s) to extract, e.g. chr1, chr2:1,000 or chr3:1000-2,000 (needs a sorted, indexed input).
  inputBinding:
    position: 105
- id: bam
  type:
  - 'null'
  - boolean
  doc: Output BAM.
  inputBinding:
    position: 103
    prefix: --bam
- id: cram
  type:
  - 'null'
  - boolean
  doc: Output CRAM (requires a reference).
  inputBinding:
    position: 103
    prefix: --cram
- id: fast
  type:
  - 'null'
  - boolean
  doc: Use fast BAM compression (and default to --bam).
  inputBinding:
    position: 103
    prefix: --fast
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output (and default to --bam).
  inputBinding:
    position: 103
    prefix: --uncompressed
- id: with_header
  type:
  - 'null'
  - boolean
  doc: Include the header in SAM output.
  inputBinding:
    position: 103
    prefix: --with-header
- id: header_only
  type:
  - 'null'
  - boolean
  doc: Print SAM header only (no alignments).
  inputBinding:
    position: 103
    prefix: --header-only
- id: no_header
  type:
  - 'null'
  - boolean
  doc: Print SAM alignment records only [default].
  inputBinding:
    position: 103
    prefix: --no-header
- id: count
  type:
  - 'null'
  - boolean
  doc: Print only the count of matching records.
  inputBinding:
    position: 103
    prefix: --count
- id: save_counts
  type:
  - 'null'
  - string
  doc: Write counts of passed/failed records to this file.
  inputBinding:
    position: 103
    prefix: --save-counts
- id: output_filename
  type: string
  doc: Name of the output file (-o).
  default: output.sam
  inputBinding:
    position: 103
    prefix: -o
- id: unoutput
  type:
  - 'null'
  - string
  doc: Write reads not selected by the filters to this file (-U).
  inputBinding:
    position: 103
    prefix: --unoutput
- id: unmap
  type:
  - 'null'
  - boolean
  doc: Set flag to UNMAP on reads not selected, then write them to the output file.
  inputBinding:
    position: 103
    prefix: --unmap
- id: fetch_pairs
  type:
  - 'null'
  - boolean
  doc: Retrieve complete pairs even when outside of region.
  inputBinding:
    position: 103
    prefix: --fetch-pairs
- id: fai_reference
  type:
  - 'null'
  - File
  doc: File listing reference names and lengths (-t).
  inputBinding:
    position: 103
    prefix: --fai-reference
- id: use_index
  type:
  - 'null'
  - boolean
  doc: Use index and multi-region iterator for regions.
  inputBinding:
    position: 103
    prefix: --use-index
- id: regions_file
  type:
  - 'null'
  - File
  doc: Use index to include only reads overlapping this BED file.
  inputBinding:
    position: 103
    prefix: --regions-file
- id: customized_index
  type:
  - 'null'
  - boolean
  doc: Expect an extra index file argument after the input file.
  inputBinding:
    position: 103
    prefix: --customized-index
- id: targets_file
  type:
  - 'null'
  - File
  doc: Only include reads that overlap the BED regions in this file (-L).
  inputBinding:
    position: 103
    prefix: --targets-file
- id: qname_file
  type:
  - 'null'
  - File
  doc: Only include reads whose read name is listed in this file.
  inputBinding:
    position: 103
    prefix: --qname-file
    valueFrom: '$((inputs.qname_file_negate ? "^" : "") + self.path)'
- id: qname_file_negate
  type:
  - 'null'
  - boolean
  doc: Negate the qname file selection (adds ^ before the file name).
- id: read_group
  type:
  - 'null'
  - string
  doc: Only include reads in read group STR or in no read group.
  inputBinding:
    position: 103
    prefix: --read-group
- id: read_group_file
  type:
  - 'null'
  - File
  doc: Only include reads in a read group listed in this file or in none.
  inputBinding:
    position: 103
    prefix: --read-group-file
    valueFrom: '$((inputs.read_group_file_negate ? "^" : "") + self.path)'
- id: read_group_file_negate
  type:
  - 'null'
  - boolean
  doc: Negate the read group file selection (adds ^ before the file name).
- id: exclude_no_read_group
  type:
  - 'null'
  - boolean
  doc: Only include reads that have a read group, exclude those that have not.
  inputBinding:
    position: 103
    prefix: --exclude-no-read_group
- id: tag
  type:
  - 'null'
  - string
  doc: Only include reads that have a tag STR1 (with associated value STR2), as STR1[:STR2].
  inputBinding:
    position: 103
    prefix: --tag
- id: tag_file
  type:
  - 'null'
  - File
  doc: File listing the values of the tag named by tag_file_tag.
  inputBinding:
    position: 103
    prefix: --tag-file
    valueFrom: $(inputs.tag_file_tag):$(self.path)
- id: tag_file_tag
  type:
  - 'null'
  - string
  doc: Tag name STR used with tag_file (STR:FILE).
- id: min_mq
  type:
  - 'null'
  - int
  doc: Only include reads that have mapping quality >= INT.
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: library
  type:
  - 'null'
  - string
  doc: Only include reads in library STR.
  inputBinding:
    position: 103
    prefix: --library
- id: min_qlen
  type:
  - 'null'
  - int
  doc: Only include reads that cover >= INT query bases (measured via CIGAR).
  inputBinding:
    position: 103
    prefix: --min-qlen
- id: expr
  type:
  - 'null'
  - string
  doc: Only include reads that match the filter expression STR.
  inputBinding:
    position: 103
    prefix: --expr
- id: require_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have all of the FLAGs present.
  inputBinding:
    position: 103
    prefix: --require-flags
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have none of the FLAGs present.
  inputBinding:
    position: 103
    prefix: --excl-flags
- id: include_flags
  type:
  - 'null'
  - string
  doc: Only include reads that have some of the FLAGs present.
  inputBinding:
    position: 103
    prefix: --include-flags
- id: exclude_all_flags
  type:
  - 'null'
  - string
  doc: Exclude reads with all of the FLAGs present (-G).
  inputBinding:
    position: 103
    prefix: -G
- id: subsample
  type:
  - 'null'
  - float
  doc: Keep only FLOAT fraction of templates/read pairs.
  inputBinding:
    position: 103
    prefix: --subsample
- id: subsample_seed
  type:
  - 'null'
  - int
  doc: Influence which reads are kept in subsampling.
  inputBinding:
    position: 103
    prefix: --subsample-seed
- id: subsample_shorthand
  type:
  - 'null'
  - string
  doc: Same as --subsample 0.FRAC --subsample-seed INT, given as INT.FRAC (-s).
  inputBinding:
    position: 103
    prefix: -s
- id: add_flags
  type:
  - 'null'
  - string
  doc: Add FLAGs to reads.
  inputBinding:
    position: 103
    prefix: --add-flags
- id: remove_flags
  type:
  - 'null'
  - string
  doc: Remove FLAGs from reads.
  inputBinding:
    position: 103
    prefix: --remove-flags
- id: remove_tag
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --remove-tag
  doc: Comma-separated read tags to strip (repeatable).
  inputBinding:
    position: 103
- id: keep_tag
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --keep-tag
  doc: Comma-separated read tags to preserve (repeatable); same as -x ^STR.
  inputBinding:
    position: 103
- id: remove_b
  type:
  - 'null'
  - boolean
  doc: Collapse the backward CIGAR operation.
  inputBinding:
    position: 103
    prefix: --remove-B
- id: sanitize
  type:
  - 'null'
  - string
  doc: Perform sanity checking and fixing on records; FLAGS is comma separated.
  inputBinding:
    position: 103
    prefix: --sanitize
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
  doc: Main output file.
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
- id: unoutput_file
  type:
  - 'null'
  - File
  doc: Reads not selected by the filters.
  outputBinding:
    glob: $(inputs.unoutput)
- id: save_counts_file
  type:
  - 'null'
  - File
  doc: Counts of passed/failed records.
  outputBinding:
    glob: $(inputs.save_counts)
