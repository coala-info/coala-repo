cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - collate
label: samtools_collate
doc: collate reads by name
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files; required unless the -o or -O options are used
    inputBinding:
      position: 2
  - id: output_to_stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout
    inputBinding:
      position: 103
      prefix: -O
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name (use prefix if not set)
    inputBinding:
      position: 103
      prefix: -o
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Uncompressed BAM output
    inputBinding:
      position: 103
      prefix: -u
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast (only primary alignments)
    inputBinding:
      position: 103
      prefix: -f
  - id: working_reads
    type:
      - 'null'
      - int
    doc: Working reads stored (with -f) [10000]
    inputBinding:
      position: 103
      prefix: -r
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level [1]
    inputBinding:
      position: 103
      prefix: -l
  - id: num_temp_files
    type:
      - 'null'
      - int
    doc: Number of temporary files [64]
    inputBinding:
      position: 103
      prefix: -n
  - id: temp_prefix
    type:
      - 'null'
      - string
    doc: Write temporary files to PREFIX.nnnn.bam
    inputBinding:
      position: 103
      prefix: -T
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 103
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
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
      - string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --output-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 103
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File[]
    doc: Prefix for output files; required unless the -o or -O options are used
    outputBinding:
      glob: $(inputs.prefix)*
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Output file name (use prefix if not set)
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_temp_prefix
    type:
      - 'null'
      - File[]
    doc: Write temporary files to PREFIX.nnnn.bam
    outputBinding:
      glob: $(inputs.temp_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
