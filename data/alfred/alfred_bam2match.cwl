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
    inputBinding:
      position: 102
      prefix: --map-qual
  - id: reference
    type: File
    doc: reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
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
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
