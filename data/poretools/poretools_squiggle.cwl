cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_squiggle
label: poretools_squiggle
doc: "Generate squiggle plots from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: num_facets
    type:
      - 'null'
      - int
    doc: The number of plot facets (sub-plots). More is better for long reads.
    default: 6
    inputBinding:
      position: 102
      prefix: --num-facets
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: theme_bw
    type:
      - 'null'
      - boolean
    doc: Use a black and white theme.
    inputBinding:
      position: 102
      prefix: --theme-bw
outputs:
  - id: saveas
    type:
      - 'null'
      - File
    doc: Save the squiggle plot to a file.
    outputBinding:
      glob: $(inputs.saveas)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
