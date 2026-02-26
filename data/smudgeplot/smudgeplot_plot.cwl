cwlVersion: v1.2
class: CommandLineTool
baseCommand: smudgeplot plot
label: smudgeplot_plot
doc: "Generate 2d histogram; infer ploidy and plot a smudgeplot.\n\nTool homepage:
  https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Mame of the input tsv file with coverages and frequencies.
    inputBinding:
      position: 1
  - id: smudgefile
    type: File
    doc: Name of the input tsv file with sizes of individual smudges.
    inputBinding:
      position: 2
  - id: n
    type: int
    doc: The expected haploid coverage.
    inputBinding:
      position: 3
  - id: col_ramp
    type:
      - 'null'
      - string
    doc: Palette used for the plot (default "viridis", other sensible options 
      are "magma", "mako" or "grey.colors" - recommended in combination with 
      --invert_cols).
    default: viridis
    inputBinding:
      position: 104
      prefix: -col_ramp
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for the plots (default png)
    default: png
    inputBinding:
      position: 104
      prefix: --format
  - id: invert_cols
    type:
      - 'null'
      - boolean
    doc: Invert the colour palette (default False).
    default: false
    inputBinding:
      position: 104
      prefix: --invert_cols
  - id: json_report
    type:
      - 'null'
      - boolean
    doc: Generate a JSON format report alongside the plots (default False)
    default: false
    inputBinding:
      position: 104
      prefix: --json_report
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: The pattern used to name the output (smudgeplot).
    inputBinding:
      position: 104
      prefix: -o
  - id: title
    type:
      - 'null'
      - string
    doc: 'name printed at the top of the smudgeplot (default: infile prefix).'
    inputBinding:
      position: 104
      prefix: --title
  - id: ylim
    type:
      - 'null'
      - float
    doc: The upper limit for the coverage sum (the y axis)
    inputBinding:
      position: 104
      prefix: -ylim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_plot.out
