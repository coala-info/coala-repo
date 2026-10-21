cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- targetcut
label: samtools_targetcut
doc: 'Cut fosmid regions (for fosmid pool only)


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type: File
  doc: Input BAM file.
  inputBinding:
    position: 104
- id: min_baseq
  type:
  - 'null'
  - int
  doc: Minimum base quality (-Q).
  inputBinding:
    position: 103
    prefix: -Q
- id: insertion_penalty
  type:
  - 'null'
  - int
  doc: Insertion penalty (-i).
  inputBinding:
    position: 103
    prefix: -i
- id: emission_0
  type:
  - 'null'
  - int
  doc: Emission score 0 (-0).
  inputBinding:
    position: 103
    prefix: '-0'
- id: emission_1
  type:
  - 'null'
  - int
  doc: Emission score 1 (-1).
  inputBinding:
    position: 103
    prefix: '-1'
- id: emission_2
  type:
  - 'null'
  - int
  doc: Emission score 2 (-2).
  inputBinding:
    position: 103
    prefix: '-2'
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
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file (-f).
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
- id: output_filename
  type: string
  doc: Name of the file that receives standard output.
  default: targetcut.txt
outputs:
- id: output
  type: File
  doc: Cut target regions (one line per region).
  outputBinding:
    glob: $(inputs.output_filename)
stdout: $(inputs.output_filename)
