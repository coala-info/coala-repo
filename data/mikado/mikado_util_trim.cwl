cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - trim
label: mikado_util_trim
doc: "Remove up to N bps from terminal exons in an annotation file.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximal length of trimmed terminal exons.
    inputBinding:
      position: 101
      prefix: -ml
  - id: as_gtf
    type:
      - 'null'
      - boolean
    doc: Write the output in GTF rather than GFF3 format.
    inputBinding:
      position: 101
      prefix: --as-gtf
  - id: ann
    type: File
    doc: Reference GTF/GFF file.
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
stdout: mikado_util_trim.out
