cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - convert
label: mikado_util_convert
doc: "BAM -> GTF <-> GFF3 -> BED12 conversions.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: Assume the input is sorted.
    inputBinding:
      position: 101
      prefix: -as
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Output format: bed12, gtf or gff3.'
    inputBinding:
      position: 101
      prefix: -of
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'Input format: bed12, gtf, gff3 or bam.'
    inputBinding:
      position: 101
      prefix: -if
  - id: transcriptomic
    type:
      - 'null'
      - boolean
    doc: Convert to a transcriptomic version.
    inputBinding:
      position: 101
      prefix: -t
  - id: gf
    type: File
    doc: Input annotation file.
    inputBinding:
      position: 201
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name; printed to standard output if omitted.
    inputBinding:
      position: 202
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_text
    type: stdout
    doc: Output printed to standard output when no output file is given.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util_convert.out
