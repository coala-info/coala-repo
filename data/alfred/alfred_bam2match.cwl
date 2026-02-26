cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - bam2match
label: alfred_bam2match
doc: "Extract matches from a BAM file against a reference genome\n\nTool homepage:
  https://github.com/tobiasrausch/alfred"
inputs:
  - id: contig_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: map_qual
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 0
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: reference
    type: File
    doc: reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
