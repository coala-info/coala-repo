cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - score
label: bwtk_score
doc: "Get summary scores of bigWig values from BED ranges\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bigwig
    type: File
    doc: Input bigWig
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: Output scores in TSV format
    inputBinding:
      position: 1
      prefix: -o
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file to score, otherwise scores chromosomes
    inputBinding:
      position: 1
      prefix: -b
  - id: bed_stat
    type:
      - 'null'
      - string
    doc: Return a BED instead with this stat in the score column
    inputBinding:
      position: 1
      prefix: -B
outputs:
  - id: scores
    type: File
    doc: Summary scores (TSV, or BED with -B)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
