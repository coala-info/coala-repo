cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- flagstat
label: samtools_flagstat
doc: 'Output simple statistics (flag counts) for an alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bam
  type: File
  doc: Input SAM/BAM/CRAM file.
  inputBinding:
    position: 104
- id: output_fmt
  type:
  - 'null'
  - string
  doc: 'Output format: json or tsv (default text).'
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
outputs:
- id: output
  type: stdout
  doc: Flag statistics.
stdout: flagstat.txt
