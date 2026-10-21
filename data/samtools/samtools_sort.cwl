cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- sort
label: samtools_sort
doc: 'Sort alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type:
  - 'null'
  - File
  doc: Input SAM/BAM/CRAM file (reads stdin when omitted).
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
    position: 110
- id: compression_level
  type:
  - 'null'
  - int
  doc: Set compression level, from 0 (uncompressed) to 9 (best).
  inputBinding:
    position: 103
    prefix: -l
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Output uncompressed data (equivalent to -l 0).
  inputBinding:
    position: 103
    prefix: -u
- id: memory_per_thread
  type:
  - 'null'
  - string
  doc: Set maximum memory per thread; suffix K/M/G recognized [768M].
  inputBinding:
    position: 103
    prefix: -m
- id: use_minimiser
  type:
  - 'null'
  - boolean
  doc: Use minimiser for clustering unaligned/unplaced reads.
  inputBinding:
    position: 103
    prefix: -M
- id: no_reverse_strand
  type:
  - 'null'
  - boolean
  doc: Do not use reverse strand (only compatible with -M).
  inputBinding:
    position: 103
    prefix: -R
- id: kmer_size
  type:
  - 'null'
  - int
  doc: Kmer size to use for minimiser [20].
  inputBinding:
    position: 103
    prefix: -K
- id: minimiser_order_file
  type:
  - 'null'
  - File
  doc: Order minimisers by their position in this FASTA file.
  inputBinding:
    position: 103
    prefix: -I
- id: window_size
  type:
  - 'null'
  - int
  doc: Window size for minimiser indexing via -I ref.fa [100].
  inputBinding:
    position: 103
    prefix: -w
- id: squash_homopolymers
  type:
  - 'null'
  - boolean
  doc: Squash homopolymers when computing minimiser.
  inputBinding:
    position: 103
    prefix: -H
- id: sort_by_name_natural
  type:
  - 'null'
  - boolean
  doc: Sort by read name (natural); cannot be used with samtools index.
  inputBinding:
    position: 103
    prefix: -n
- id: sort_by_name_ascii
  type:
  - 'null'
  - boolean
  doc: Sort by read name (ASCII); cannot be used with samtools index.
  inputBinding:
    position: 103
    prefix: -N
- id: sort_by_tag
  type:
  - 'null'
  - string
  doc: Sort by value of TAG. Uses position as secondary index (or read name if -n is set).
  inputBinding:
    position: 103
    prefix: -t
- id: output_filename
  type: string
  doc: Write final output to this file (-o).
  default: sorted.bam
  inputBinding:
    position: 103
    prefix: -o
- id: temp_prefix
  type:
  - 'null'
  - string
  doc: Write temporary files to PREFIX.nnnn.bam.
  inputBinding:
    position: 103
    prefix: -T
- id: template_coordinate
  type:
  - 'null'
  - boolean
  doc: Sort by template-coordinate.
  inputBinding:
    position: 103
    prefix: --template-coordinate
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
  doc: Sorted alignment file.
  outputBinding:
    glob: $(inputs.output_filename)
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the output file when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).bai
    - $(inputs.output_filename).csi
    - $(inputs.output_filename).crai
