cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_hist
label: poretools_hist
doc: "Generate histograms of read lengths from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum read length to be included in histogram.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum read length to be included in histogram.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: num_bins
    type:
      - 'null'
      - int
    doc: The number of histogram bins.
    inputBinding:
      position: 102
      prefix: --num-bins
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
  - id: watch
    type:
      - 'null'
      - boolean
    doc: Monitor a directory.
    inputBinding:
      position: 102
      prefix: --watch
outputs:
  - id: saveas
    type:
      - 'null'
      - File
    doc: Save the plot to a file.
    outputBinding:
      glob: $(inputs.saveas)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
