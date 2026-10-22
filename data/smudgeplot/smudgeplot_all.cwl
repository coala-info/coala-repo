cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smudgeplot
  - all
label: smudgeplot_all
doc: "Runs all the steps (with default options).\n\nTool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Name of the input tsv file with covarages and frequencies.
    inputBinding:
      position: 1
  - id: col_ramp
    type:
      - 'null'
      - string
    doc: Palette used for the plot (default "viridis", other sensible options 
      are "magma", "mako" or "grey.colors" - recommended in combination with 
      --invert_cols).
    inputBinding:
      position: 102
      prefix: -col_ramp
  - id: cov
    type:
      - 'null'
      - int
    doc: The assumed coverage (no inference of 1n coverage is made).
    inputBinding:
      position: 102
      prefix: -cov
  - id: cov_max
    type:
      - 'null'
      - int
    doc: Maximal coverage to explore
    inputBinding:
      position: 102
      prefix: -cov_max
  - id: cov_min
    type:
      - 'null'
      - int
    doc: Minimal coverage to explore
    inputBinding:
      position: 102
      prefix: -cov_min
  - id: distance
    type:
      - 'null'
      - int
    doc: Manthattan distance of k-mer pairs that are considered neighbouring for
      local aggregation purposes.
    inputBinding:
      position: 102
      prefix: -distance
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for the plots
    inputBinding:
      position: 102
      prefix: --format
  - id: invert_cols
    type:
      - 'null'
      - boolean
    doc: Invert the colour palette
    inputBinding:
      position: 102
      prefix: --invert_cols
  - id: json_report
    type:
      - 'null'
      - boolean
    doc: Generate a JSON format report alongside the plots
    inputBinding:
      position: 102
      prefix: --json_report
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: The pattern used to name the output (smudgeplot).
    inputBinding:
      position: 102
      prefix: -o
  - id: title
    type:
      - 'null'
      - string
    doc: 'name printed at the top of the smudgeplot (default: infile prefix).'
    inputBinding:
      position: 102
      prefix: --title
  - id: ylim
    type:
      - 'null'
      - float
    doc: The upper limit for the coverage sum (the y axis)
    inputBinding:
      position: 102
      prefix: -ylim
outputs:
  - id: all_outputs
    type:
      type: array
      items: File
    doc: Plots, centrality table, annotated smudge file (.sma) and smudge report (.tsv), named by the output pattern.
    outputBinding:
      glob: $((inputs.output_pattern || 'smudgeplot') + '*')
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (progress messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_all.out
stderr: smudgeplot_all.err
