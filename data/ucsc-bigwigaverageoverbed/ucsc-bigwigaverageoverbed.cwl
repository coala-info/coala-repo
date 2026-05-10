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
  - id: bed_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `bed_out_path`
    inputBinding:
      position: 104
      prefix: --bed-out
  - id: sample_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `sample_path`
    inputBinding:
      position: 105
      prefix: --sample
  - id: stats_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `stats_path`
    inputBinding:
      position: 106
      prefix: --stats
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
      glob: $(inputs.stats_path)
  - id: sample
    type:
      - 'null'
      - File
    doc: Write out sampling to this file
    outputBinding:
      glob: $(inputs.sample_path)
  - id: bed_out
    type:
      - 'null'
      - File
    doc: Make output a BED file with the average score in the score column
    outputBinding:
      glob: $(inputs.bed_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigaverageoverbed:482--h0b57e2e_0
