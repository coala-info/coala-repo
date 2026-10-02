cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - phase
label: samtools_phase
doc: Call and phase heterozygous SNPs in a BAM file
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: block_length
    type:
      - 'null'
      - int
    doc: block length
    inputBinding:
      position: 102
      prefix: -k
  - id: prefix_bams
    type:
      - 'null'
      - string
    doc: prefix of BAMs to output
    inputBinding:
      position: 102
      prefix: -b
  - id: min_het_phred_lod
    type:
      - 'null'
      - int
    doc: min het phred-LOD
    inputBinding:
      position: 102
      prefix: -q
  - id: min_bq
    type:
      - 'null'
      - int
    doc: min base quality in het calling
    inputBinding:
      position: 102
      prefix: --min-BQ
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: max read depth
    inputBinding:
      position: 102
      prefix: -D
  - id: no_fix_chimeras
    type:
      - 'null'
      - boolean
    doc: do not attempt to fix chimeras
    inputBinding:
      position: 102
      prefix: -F
  - id: drop_ambiguous_phase
    type:
      - 'null'
      - boolean
    doc: drop reads with ambiguous phase
    inputBinding:
      position: 102
      prefix: -A
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
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
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: output_prefix_bams
    type:
      - 'null'
      - File[]
    doc: prefix of BAMs to output
    outputBinding:
      glob: $(inputs.prefix_bams)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
