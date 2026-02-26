cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - count_dna
label: alfred_count_dna
doc: "Count DNA coverage and fragments from aligned BAM files\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: aligned_bam
    type: File
    doc: Input aligned BAM file
    inputBinding:
      position: 1
  - id: fragments
    type:
      - 'null'
      - string
    doc: count illumina PE fragments using lower and upper bound on insert size,
      i.e. -f 0,10000
    inputBinding:
      position: 102
      prefix: --fragments
  - id: interval_file
    type:
      - 'null'
      - File
    doc: interval file, used if present
    inputBinding:
      position: 102
      prefix: --interval-file
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: window_num
    type:
      - 'null'
      - int
    doc: '#windows per chr, used if #n>0'
    default: 0
    inputBinding:
      position: 102
      prefix: --window-num
  - id: window_offset
    type:
      - 'null'
      - int
    doc: window offset
    default: 10000
    inputBinding:
      position: 102
      prefix: --window-offset
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    default: 10000
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: coverage output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
