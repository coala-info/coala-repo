cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigbedtobed
label: bigtools_bigbedtobed
doc: "Converts a bigBed file to a BED file.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs:
  - id: input
    type: File
    doc: The bigBed file to convert.
    inputBinding:
      position: 1
  - id: output_bed
    type: string
    doc: the path of the bed to output to
    inputBinding:
      position: 2
  - id: overlap_bed
    type:
      - 'null'
      - File
    doc: If set, restrict output to regions overlapping the bed file
    inputBinding:
      position: 3
  - id: chrom
    type:
      - 'null'
      - string
    doc: If set, restrict output to given chromosome
    inputBinding:
      position: 102
      prefix: --chrom
  - id: end
    type:
      - 'null'
      - int
    doc: If set, restrict output to regions less than it
    inputBinding:
      position: 102
      prefix: --end
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Set the number of threads to use.
    inputBinding:
      position: 102
      prefix: -t
  - id: start
    type:
      - 'null'
      - int
    doc: If set, restrict output to regions greater than or equal to it
    inputBinding:
      position: 102
      prefix: --start
  - id: inmemory
    type:
      - 'null'
      - boolean
    doc: Do not create temporary files for intermediate data.
    inputBinding:
      position: 102
      prefix: --inmemory
  - id: zoom
    type:
      - 'null'
      - int
    doc: If set, outputs the values for a given zoom level.
    inputBinding:
      position: 102
      prefix: --zoom
outputs:
  - id: output
    type: File
    doc: The output BED file.
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
