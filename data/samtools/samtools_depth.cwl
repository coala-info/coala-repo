cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - depth
label: samtools_depth
doc: Compute depth of coverage for BAM/SAM/CRAM files
inputs:
  - id: in_bams
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: all_positions
    type:
      - 'null'
      - boolean
    doc: Output all positions (including zero depth)
    inputBinding:
      position: 102
      prefix: -a
  - id: absolutely_all_positions
    type:
      - 'null'
      - boolean
    doc: Output absolutely all positions, including unused ref seqs
    inputBinding:
      position: 102
      prefix: -aa
  - id: region
    type:
      - 'null'
      - string
    doc: Specify a region in chr or chr:from-to syntax
    inputBinding:
      position: 102
      prefix: -r
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Use bed FILE for list of regions
    inputBinding:
      position: 102
      prefix: -b
  - id: file_list
    type:
      - 'null'
      - File
    doc: Specify list of input BAM/SAM/CRAM filenames
    inputBinding:
      position: 102
      prefix: -f
  - id: custom_indexes
    type:
      - 'null'
      - boolean
    doc: Use custom index files (in -X *.bam *.bam.bai order)
    inputBinding:
      position: 102
      prefix: -X
  - id: remove_flags
    type:
      - 'null'
      - int
    doc: Remove specified flags from default filter-out flag list
    inputBinding:
      position: 102
      prefix: -g
  - id: excl_flags
    type:
      - 'null'
      - string
    doc: Add specified flags to the default filter-out flag list
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: incl_flags
    type:
      - 'null'
      - string
    doc: Only include records with at least one the FLAGs present
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: require_flags
    type:
      - 'null'
      - string
    doc: Only include records with all of the FLAGs present
    inputBinding:
      position: 102
      prefix: --require-flags
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a file header line
    inputBinding:
      position: 102
      prefix: -H
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 102
      prefix: -l
  - id: output_file
    type:
      - 'null'
      - string
    doc: Write output to FILE
    inputBinding:
      position: 102
      prefix: -o
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Filter bases with base quality smaller than INT
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Filter alignments with mapping quality smaller than INT
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: include_deletions
    type:
      - 'null'
      - boolean
    doc: Include reads with deletions in depth computation
    inputBinding:
      position: 102
      prefix: -J
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: Do not count overlapping reads within a template
    inputBinding:
      position: 102
      prefix: -s
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
