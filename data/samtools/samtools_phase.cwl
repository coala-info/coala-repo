cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- phase
label: samtools_phase
doc: 'Call and phase heterozygous SNPs


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type: File
  doc: Input sorted BAM file.
  inputBinding:
    position: 104
- id: prefix_bams
  type: string
  doc: Prefix of the BAM files to output (-b).
  default: phased
  inputBinding:
    position: 103
    prefix: -b
- id: block_length
  type:
  - 'null'
  - int
  doc: Block length [13].
  inputBinding:
    position: 103
    prefix: -k
- id: min_het_phred_lod
  type:
  - 'null'
  - int
  doc: Min het phred-LOD [37].
  inputBinding:
    position: 103
    prefix: -q
- id: min_bq
  type:
  - 'null'
  - int
  doc: Min base quality in het calling [13].
  inputBinding:
    position: 103
    prefix: --min-BQ
- id: max_read_depth
  type:
  - 'null'
  - int
  doc: Max read depth [256].
  inputBinding:
    position: 103
    prefix: -D
- id: no_fix_chimeras
  type:
  - 'null'
  - boolean
  doc: Do not attempt to fix chimeras.
  inputBinding:
    position: 103
    prefix: -F
- id: drop_ambiguous_phase
  type:
  - 'null'
  - boolean
  doc: Drop reads with ambiguous phase.
  inputBinding:
    position: 103
    prefix: -A
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
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
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
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
  doc: Specify a single output file format option (repeatable).
  inputBinding:
    position: 103
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
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
outputs:
- id: output_bams
  type:
    type: array
    items: File
  doc: Phased BAM files (prefix.0.bam, prefix.1.bam, prefix.chimera.bam).
  outputBinding:
    glob:
    - $(inputs.prefix_bams).*.bam
- id: stats
  type: stdout
  doc: Phasing statistics printed to standard output.
stdout: phase_stats.txt
