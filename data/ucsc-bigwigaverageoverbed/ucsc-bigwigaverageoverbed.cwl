cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigAverageOverBed
label: ucsc-bigwigaverageoverbed
doc: "Compute average score of a bigWig file over each item in a BED file.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bw
    type: File
    doc: Input bigWig file
    inputBinding:
      position: 1
  - id: in_bed
    type: File
    doc: Input BED file (at least 3 columns)
    inputBinding:
      position: 2
  - id: min_max
    type:
      - 'null'
      - boolean
    doc: Include min and max in the output
    inputBinding:
      position: 103
      prefix: -minMax
outputs:
  - id: out_tab
    type: File
    doc: Output tab-separated file
    outputBinding:
      glob: '*.out'
  - id: stats
    type:
      - 'null'
      - File
    doc: Write out statistics to this file
    outputBinding:
      glob: $(inputs.stats)
  - id: sample
    type:
      - 'null'
      - File
    doc: Write out sampling to this file
    outputBinding:
      glob: $(inputs.sample)
  - id: bed_out
    type:
      - 'null'
      - File
    doc: Make output a BED file with the average score in the score column
    outputBinding:
      glob: $(inputs.bed_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigaverageoverbed:482--h0b57e2e_0
