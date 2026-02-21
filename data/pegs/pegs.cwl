cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegs
label: pegs
doc: "Peak-set Enrichment Gene-set Analysis (PEGS)\n\nTool homepage: https://github.com/pegjs/pegjs"
inputs:
  - id: gene_intervals
    type: File
    doc: Gene intervals file
    inputBinding:
      position: 1
  - id: basename
    type:
      - 'null'
      - string
    doc: Basename for output files
    inputBinding:
      position: 102
      prefix: --name
  - id: clusters_axis_label
    type:
      - 'null'
      - string
    doc: Label for the clusters axis (X-axis)
    inputBinding:
      position: 102
      prefix: --x-label
  - id: color
    type:
      - 'null'
      - string
    doc: Color for the heatmap
    inputBinding:
      position: 102
      prefix: --color
  - id: distance
    type:
      - 'null'
      - type: array
        items: int
    doc: Distance(s) for enrichment analysis
    inputBinding:
      position: 102
      prefix: -d
  - id: dump_raw_data
    type:
      - 'null'
      - boolean
    doc: Dump raw data used for analysis
    inputBinding:
      position: 102
      prefix: --dump-raw-data
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for plots
    inputBinding:
      position: 102
      prefix: --format
  - id: gene_cluster_file
    type:
      type: array
      items: File
    doc: Gene cluster file(s)
    inputBinding:
      position: 102
      prefix: --genes
  - id: heatmap
    type:
      - 'null'
      - string
    doc: Heatmap filename
    inputBinding:
      position: 102
      prefix: -m
  - id: heatmap_palette
    type:
      - 'null'
      - type: array
        items: string
    doc: Heatmap palette options (OPTION=VALUE)
    inputBinding:
      position: 102
      prefix: --heatmap-palette
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 102
      prefix: -k
  - id: peak_set_file
    type:
      type: array
      items: File
    doc: Peak set file(s)
    inputBinding:
      position: 102
      prefix: --peaks
  - id: peaksets_axis_label
    type:
      - 'null'
      - string
    doc: Label for the peaksets axis (Y-axis)
    inputBinding:
      position: 102
      prefix: --y-label
  - id: tads_file
    type:
      - 'null'
      - File
    doc: TADs file
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
  - id: xlsx
    type:
      - 'null'
      - File
    doc: XLSX output filename
    outputBinding:
      glob: $(inputs.xlsx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegs:0.6.6--pyhdfd78af_0
