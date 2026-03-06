cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- sort
label: samtools_sort
doc: "Sort alignment files by coordinates or name\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_bam
  type: File
  doc: Input BAM file
  inputBinding:
    position: 103
- id: compression_level
  type:
  - 'null'
  - int
  doc: Set compression level, from 0 (uncompressed) to 9 (best)
  inputBinding:
    position: 102
    prefix: -l
- id: input_fmt_option
  type:
  - 'null'
  - string
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: kmer_size
  type:
  - 'null'
  - int
  doc: Kmer size to use for minimiser
  default: 20
  inputBinding:
    position: 102
    prefix: -K
- id: memory_per_thread
  type:
  - 'null'
  - string
  doc: Set maximum memory per thread; suffix K/M/G recognized
  default: 768M
  inputBinding:
    position: 102
    prefix: -m
- id: minimiser_order_file
  type:
  - 'null'
  - File
  doc: Order minimisers by their position in FILE FASTA
  inputBinding:
    position: 102
    prefix: -I
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: no_reverse_strand
  type:
  - 'null'
  - boolean
  doc: Do not use reverse strand (only compatible with -M)
  inputBinding:
    position: 102
    prefix: -R
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
  - string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: sort_by_name_ascii
  type:
  - 'null'
  - boolean
  doc: 'Sort by read name (ASCII): cannot be used with samtools index'
  inputBinding:
    position: 102
    prefix: -N
- id: sort_by_name_natural
  type:
  - 'null'
  - boolean
  doc: 'Sort by read name (natural): cannot be used with samtools index'
  inputBinding:
    position: 102
    prefix: -n
- id: sort_by_tag
  type:
  - 'null'
  - string
  doc: Sort by value of TAG. Uses position as secondary index (or read name if 
    -n is set)
  inputBinding:
    position: 102
    prefix: -t
- id: squash_homopolymers
  type:
  - 'null'
  - boolean
  doc: Squash homopolymers when computing minimiser
  inputBinding:
    position: 102
    prefix: -H
- id: temp_prefix
  type:
  - 'null'
  - string
  doc: Write temporary files to PREFIX.nnnn.bam
  inputBinding:
    position: 102
    prefix: -T
- id: template_coordinate
  type:
  - 'null'
  - boolean
  doc: Sort by template-coordinate
  inputBinding:
    position: 102
    prefix: --template-coordinate
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
  doc: Output uncompressed data (equivalent to -l 0)
  inputBinding:
    position: 102
    prefix: -u
- id: use_minimiser
  type:
  - 'null'
  - boolean
  doc: Use minimiser for clustering unaligned/unplaced reads
  inputBinding:
    position: 102
    prefix: -M
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: window_size
  type:
  - 'null'
  - int
  doc: Window size for minimiser indexing via -I ref.fa
  default: 100
  inputBinding:
    position: 102
    prefix: -w
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
arguments:
- position: 101
  prefix: -o
  valueFrom: $(inputs.input_bam.nameroot).sorted.bam
outputs:
- id: output_file
  type: File
  doc: The sorted BAM file
  outputBinding:
    glob: $(inputs.input_bam.nameroot).sorted.bam
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
