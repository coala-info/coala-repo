cwlVersion: v1.2
class: CommandLineTool
baseCommand: consel
label: consel
doc: "Assess the confidence of phylogenetic tree selection by calculating p-values
  for various statistical tests.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the input files (e.g., the name used in previous steps like makermt).
      If not provided, the tool may attempt to read from stdin.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel.out
