cwlVersion: v1.2
class: CommandLineTool
baseCommand: Mikado util
label: mikado_util
doc: "Mikado util\n\nTool homepage: https://github.com/lucventurini/mikado"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (awk_gtf, class_codes, collect_compare, convert, 
      grep, metrics, stats, trim)
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util.out
