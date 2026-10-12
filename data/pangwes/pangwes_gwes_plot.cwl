cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gwes_plot.r
label: pangwes_gwes_plot
doc: "Draw a GWES Manhattan plot from the unitig_distance output (9-column links
  file with unitig pair, average graph distance, SpydrPick ARACNE flag, mutual information
  score and graph distance statistics).\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs:
  - id: input
    type: File
    doc: Input links file (required)
    inputBinding:
      position: 1
      prefix: -i
  - id: num_assemblies
    type: int
    doc: Number of assemblies in the analysis (required)
    inputBinding:
      position: 2
      prefix: -n
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output plot path (default: ./pangwes_plot.png)'
    inputBinding:
      position: 3
      prefix: -o
  - id: ld_dist
    type:
      - 'null'
      - int
    doc: 'LD distance cutoff (default: 50000)'
    inputBinding:
      position: 4
      prefix: -l
  - id: no_deps
    type:
      - 'null'
      - boolean
    doc: Generate a basic plot without any R package dependencies (much slower)
    inputBinding:
      position: 5
      prefix: --no-deps
outputs:
  - id: plot
    type: File
    doc: GWES Manhattan plot (PNG)
    outputBinding:
      glob: "$(inputs.output || 'pangwes_plot.png')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
