cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- depth
label: samtools_depth
doc: 'Compute the read depth at each position or region


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bams
  type:
  - 'null'
  - type: array
    items: File
  doc: Input SAM/BAM/CRAM files (index needed for -r and -b).
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
- id: all_positions
  type:
  - 'null'
  - boolean
  doc: Output all positions (including zero depth).
  inputBinding:
    position: 103
    prefix: -a
- id: absolutely_all_positions
  type:
  - 'null'
  - boolean
  doc: Output absolutely all positions, including unused reference sequences (-aa).
  inputBinding:
    position: 103
    prefix: -aa
- id: region
  type:
  - 'null'
  - string
  doc: Region in chr or chr:from-to syntax (-r).
  inputBinding:
    position: 103
    prefix: -r
- id: bed_file
  type:
  - 'null'
  - File
  doc: BED file with the list of regions (-b).
  inputBinding:
    position: 103
    prefix: -b
- id: file_list
  type:
  - 'null'
  - File
  doc: List of input BAM/SAM/CRAM filenames (-f).
  inputBinding:
    position: 103
    prefix: -f
- id: custom_indexes
  type:
  - 'null'
  - boolean
  doc: Use custom index files (in -X *.bam *.bam.bai order).
  inputBinding:
    position: 103
    prefix: -X
- id: remove_flags
  type:
  - 'null'
  - string
  doc: Remove specified flags from the default filter-out flag list (-g).
  inputBinding:
    position: 103
    prefix: -g
- id: excl_flags
  type:
  - 'null'
  - string
  doc: Add specified flags to the default filter-out flag list [UNMAP,SECONDARY,QCFAIL,DUP].
  inputBinding:
    position: 103
    prefix: --excl-flags
- id: incl_flags
  type:
  - 'null'
  - string
  doc: Only include records with at least one of the FLAGs present [0].
  inputBinding:
    position: 103
    prefix: --incl-flags
- id: require_flags
  type:
  - 'null'
  - string
  doc: Only include records with all of the FLAGs present [0].
  inputBinding:
    position: 103
    prefix: --require-flags
- id: header
  type:
  - 'null'
  - boolean
  doc: Print a file header line.
  inputBinding:
    position: 103
    prefix: -H
- id: min_read_length
  type:
  - 'null'
  - int
  doc: Minimum read length [0].
  inputBinding:
    position: 103
    prefix: -l
- id: output_filename
  type: string
  doc: Write output to this file (-o).
  default: depth.txt
  inputBinding:
    position: 103
    prefix: -o
- id: min_base_quality
  type:
  - 'null'
  - int
  doc: Filter bases with base quality smaller than INT [0].
  inputBinding:
    position: 103
    prefix: --min-BQ
- id: min_mapping_quality
  type:
  - 'null'
  - int
  doc: Filter alignments with mapping quality smaller than INT [0].
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: include_deletions
  type:
  - 'null'
  - boolean
  doc: Include reads with deletions in depth computation.
  inputBinding:
    position: 103
    prefix: -J
- id: no_overlap
  type:
  - 'null'
  - boolean
  doc: Do not count overlapping reads within a template.
  inputBinding:
    position: 103
    prefix: -s
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
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
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
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
outputs:
- id: output
  type: File
  doc: Per-position depth table.
  outputBinding:
    glob: $(inputs.output_filename)
