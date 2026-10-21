cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- collate
label: samtools_collate
doc: 'Shuffles and groups reads together by their names


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
  inputBinding:
    position: 104
- id: output_filename
  type: string
  doc: Output file name (-o); the temporary prefix is not needed then.
  default: collated.bam
  inputBinding:
    position: 103
    prefix: -o
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output.
  inputBinding:
    position: 103
    prefix: -u
- id: fast
  type:
  - 'null'
  - boolean
  doc: Fast (only primary alignments).
  inputBinding:
    position: 103
    prefix: -f
- id: working_reads
  type:
  - 'null'
  - int
  doc: Working reads stored (with -f) [10000].
  inputBinding:
    position: 103
    prefix: -r
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level [1].
  inputBinding:
    position: 103
    prefix: -l
- id: num_temp_files
  type:
  - 'null'
  - int
  doc: Number of temporary files [64].
  inputBinding:
    position: 103
    prefix: -n
- id: temp_prefix
  type:
  - 'null'
  - string
  doc: Write temporary files to PREFIX.nnnn.bam.
  inputBinding:
    position: 103
    prefix: -T
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
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
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
outputs:
- id: output
  type: File
  doc: Collated alignment file.
  outputBinding:
    glob: $(inputs.output_filename)
