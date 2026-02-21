cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - collate
label: samtools_collate
doc: "Shuffles and groups reads together by name\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: prefix_positional
    type:
      - 'null'
      - string
    doc: Output prefix (required unless -o or -O is used)
    inputBinding:
      position: 2
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level
    default: 1
    inputBinding:
      position: 103
      prefix: -l
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast (only primary alignments)
    inputBinding:
      position: 103
      prefix: -f
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
  - id: nb_temp_files
    type:
      - 'null'
      - int
    doc: Number of temporary files
    default: 64
    inputBinding:
      position: 103
      prefix: -n
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
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
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --output-fmt-option
  - id: output_to_stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout
    inputBinding:
      position: 103
      prefix: -O
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 103
      prefix: --reference
  - id: temp_prefix
    type:
      - 'null'
      - string
    doc: Write temporary files to PREFIX.nnnn.bam
    inputBinding:
      position: 103
      prefix: -T
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 103
      prefix: --threads
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Uncompressed BAM output
    inputBinding:
      position: 103
      prefix: -u
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 103
      prefix: --verbosity
  - id: working_reads
    type:
      - 'null'
      - int
    doc: Working reads stored (with -f)
    default: 10000
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name (use prefix if not set)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
