cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - telmotif
label: alfred_telmotif
doc: "Identify telomeric motifs in sequencing data\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: quality
    type:
      - 'null'
      - int
    doc: min. sequence quality
    inputBinding:
      position: 102
      prefix: --quality
  - id: reference
    type: File
    doc: reference fasta file (required)
    inputBinding:
      position: 102
      prefix: --reference
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 102
      prefix: --wsize
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
