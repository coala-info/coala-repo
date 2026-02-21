cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - depth
label: samtools_depth
doc: "Compute the depth of coverage for one or more BAM/SAM/CRAM files.\n\nTool homepage:
  https://github.com/samtools/samtools"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM/SAM/CRAM files
    inputBinding:
      position: 1
  - id: absolutely_all_positions
    type:
      - 'null'
      - boolean
    doc: Output absolutely all positions, including unused ref seqs
    inputBinding:
      position: 102
      prefix: -aa
  - id: all_positions
    type:
      - 'null'
      - boolean
    doc: Output all positions (including zero depth)
    inputBinding:
      position: 102
      prefix: -a
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Use bed FILE for list of regions
    inputBinding:
      position: 102
      prefix: -b
  - id: custom_index
    type:
      - 'null'
      - boolean
    doc: Use custom index files (in -X *.bam *.bam.bai order)
    inputBinding:
      position: 102
      prefix: -X
  - id: excl_flags
    type:
      - 'null'
      - string
    doc: Add specified flags to the default filter-out flag list
    default: UNMAP,SECONDARY,QCFAIL,DUP
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: file_list
    type:
      - 'null'
      - File
    doc: Specify list of input BAM/SAM/CRAM filenames
    inputBinding:
      position: 102
      prefix: -f
  - id: incl_flags
    type:
      - 'null'
      - string
    doc: Only include records with at least one the FLAGs present
    default: '0'
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: include_deletions
    type:
      - 'null'
      - boolean
    doc: Include reads with deletions in depth computation
    inputBinding:
      position: 102
      prefix: -J
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
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Filter bases with base quality smaller than INT
    default: 0
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Filter alignments with mapping quality smaller than INT
    default: 0
    inputBinding:
      position: 102
      prefix: --min-MQ
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    default: 0
    inputBinding:
      position: 102
      prefix: -l
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: Do not count overlapping reads within a template
    inputBinding:
      position: 102
      prefix: -s
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print a file header line
    inputBinding:
      position: 102
      prefix: -H
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: Specify a region in chr or chr:from-to syntax
    inputBinding:
      position: 102
      prefix: -r
  - id: remove_flags
    type:
      - 'null'
      - int
    doc: Remove specified flags from default filter-out flag list
    inputBinding:
      position: 102
      prefix: -g
  - id: require_flags
    type:
      - 'null'
      - string
    doc: Only include records with all of the FLAGs present
    default: '0'
    inputBinding:
      position: 102
      prefix: --require-flags
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
