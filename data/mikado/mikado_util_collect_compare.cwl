cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - collect_compare
label: mikado_util_collect_compare
doc: "Collect and collapse multiple `mikado compare` summary statistics.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: out
    type:
      - 'null'
      - string
    doc: Prefix for the output files.
    inputBinding:
      position: 101
      prefix: -o
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: Formats to print the tables into (for example grid, tsv).
    inputBinding:
      position: 101
      prefix: -fmt
  - id: levels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Levels to print: all, f1, sn, pr, matches, missed_novel (default f1 sn pr).'
    inputBinding:
      position: 101
      prefix: -l
  - id: stat
    type:
      - 'null'
      - type: array
        items: File
    doc: Summary statistics files (.stats) from mikado compare.
    inputBinding:
      position: 1
outputs:
  - id: tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Collected tables.
    outputBinding:
      glob: '$(inputs.out ? inputs.out : ''collect_compare'')*'
  - id: stdout_text
    type: stdout
    doc: Standard output.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util_collect_compare.out
