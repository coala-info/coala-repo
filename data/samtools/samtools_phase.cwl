cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - phase
label: samtools_phase
doc: "Call and phase heterozygous SNPs\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: block_length
    type:
      - 'null'
      - int
    doc: block length
    default: 13
    inputBinding:
      position: 102
      prefix: -k
  - id: drop_ambiguous
    type:
      - 'null'
      - boolean
    doc: drop reads with ambiguous phase
    inputBinding:
      position: 102
      prefix: -A
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: max read depth
    default: 256
    inputBinding:
      position: 102
      prefix: -D
  - id: min_bq
    type:
      - 'null'
      - int
    doc: min base quality in het calling
    default: 13
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: min_het_lod
    type:
      - 'null'
      - int
    doc: min het phred-LOD
    default: 37
    inputBinding:
      position: 102
      prefix: -q
  - id: no_fix_chimeras
    type:
      - 'null'
      - boolean
    doc: do not attempt to fix chimeras
    inputBinding:
      position: 102
      prefix: -F
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
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
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix of BAMs to output
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
