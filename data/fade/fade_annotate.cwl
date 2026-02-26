cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fade
  - annotate
label: fade_annotate
doc: "performs re-alignment of soft-clips and annotates bam records with bitflag (rs)
  and realignment tags (am)\n\nTool homepage: https://github.com/blachlylab/fade"
inputs:
  - id: input_bam_sam
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
  - id: indexed_fasta_reference
    type: File
    doc: Indexed fasta reference
    inputBinding:
      position: 2
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum number of bases for a soft-clip to be considered for artifact 
      detection
    inputBinding:
      position: 103
      prefix: --min-length
  - id: threads
    type:
      - 'null'
      - int
    doc: extra threads for parsing the bam file
    inputBinding:
      position: 103
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Number of bases considered outside of read or mate region for 
      re-alignment
    inputBinding:
      position: 103
      prefix: --window-size
outputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: output bam
    outputBinding:
      glob: $(inputs.bam)
  - id: ubam
    type:
      - 'null'
      - File
    doc: output uncompressed bam
    outputBinding:
      glob: $(inputs.ubam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fade:0.6.0--h9ee0642_0
