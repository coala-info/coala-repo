cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-histogram
label: genomedata_genomedata-histogram
doc: "Print a histogram of values from a genomedata archive\n\nTool homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: gdarchive
    type: string
    doc: genomedata archive
    inputBinding:
      position: 1
  - id: trackname
    type: string
    doc: track name
    inputBinding:
      position: 2
  - id: include_coords
    type:
      - 'null'
      - File
    doc: limit summary to genomic coordinates in FILE
    inputBinding:
      position: 103
      prefix: --include-coords
  - id: num_bins
    type:
      - 'null'
      - int
    doc: use BINS bins
    inputBinding:
      position: 103
      prefix: --num-bins
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-histogram.out
