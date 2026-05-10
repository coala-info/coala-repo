cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - tracks
label: alfred_tracks
doc: "Generate track files from aligned BAM files\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: aligned_bam
    type: File
    doc: Input aligned BAM file
    inputBinding:
      position: 1
  - id: covtype
    type:
      - 'null'
      - int
    doc: 'coverage type (0: sequencing coverage, 1: spanning coverage, 2: footprinting)'
    inputBinding:
      position: 102
      prefix: --covtype
  - id: format
    type:
      - 'null'
      - string
    doc: output format [bedgraph|bed|wiggle|raw]
    inputBinding:
      position: 102
      prefix: --format
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: normalize
    type:
      - 'null'
      - int
    doc: '#pairs to normalize to (0: no normalization)'
    inputBinding:
      position: 102
      prefix: --normalize
  - id: resolution
    type:
      - 'null'
      - float
    doc: fractional resolution ]0,1]
    inputBinding:
      position: 102
      prefix: --resolution
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: track file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
