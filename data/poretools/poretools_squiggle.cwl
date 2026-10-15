cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poretools
  - squiggle
label: poretools_squiggle
doc: "Generate squiggle plots from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files (staged in the working directory, because the plots are written next to them).
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: num_facets
    type:
      - 'null'
      - int
    doc: The number of plot facets (sub-plots). More is better for long reads.
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
  - id: saveas_path
    type: string
    doc: Save the squiggle plots as files with this extension (png or pdf); one file per FAST5 file.
    inputBinding:
      position: 103
      prefix: --saveas
outputs:
  - id: saveas
    type:
      type: array
      items: File
    doc: One squiggle plot per FAST5 file, named <fast5 name>.<extension>
    outputBinding:
      glob: $('*.' + inputs.saveas_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
