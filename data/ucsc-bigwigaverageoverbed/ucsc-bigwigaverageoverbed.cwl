cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigAverageOverBed
label: ucsc-bigwigaverageoverbed
doc: "Compute average score of big wig over each bed, which may have introns.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bw
    type: File
    doc: "Input bigWig file"
    inputBinding:
      position: 1
  - id: in_bed
    type: File
    doc: "Input BED file (names should be unique)"
    inputBinding:
      position: 2
  - id: out_tab
    type: string
    doc: "Name of the output tab-separated file"
    inputBinding:
      position: 3
  - id: stats
    type:
      - 'null'
      - string
    doc: "Output a collection of overall statistics to this file"
    inputBinding:
      position: 101
      prefix: -stats=
      separate: false
  - id: bed_out
    type:
      - 'null'
      - string
    doc: "Make output bed that is echo of input bed but with mean column appended"
    inputBinding:
      position: 101
      prefix: -bedOut=
      separate: false
  - id: sample_around_center
    type:
      - 'null'
      - int
    doc: "Take sample at region N bases wide centered around bed item, rather than the usual sample in the bed item"
    inputBinding:
      position: 101
      prefix: -sampleAroundCenter=
      separate: false
  - id: min_max
    type:
      - 'null'
      - boolean
    doc: "Include two additional columns containing the min and max observed in the area"
    inputBinding:
      position: 101
      prefix: -minMax
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: "Include a TSV header for input to other tools"
    inputBinding:
      position: 101
      prefix: -tsv
outputs:
  - id: out_out_tab
    type: File
    doc: "Tab-separated table with name, size, covered, sum, mean0, mean"
    outputBinding:
      glob: $(inputs.out_tab)
  - id: out_stats
    type: ['null', File]
    doc: "Overall statistics file"
    outputBinding:
      glob: $(inputs.stats)
  - id: out_bed_out
    type: ['null', File]
    doc: "BED file with the mean column appended"
    outputBinding:
      glob: $(inputs.bed_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigaverageoverbed:482--h0b57e2e_0
