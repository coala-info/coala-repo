cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-slice
label: sambamba_slice
doc: "Fast copy of a region from indexed BAM or FASTA file to a new file\n\nTool homepage:
  https://github.com/biod/sambamba"
inputs:
  - id: input_file
    type: File
    doc: Input BAM or FASTA file
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Regions to copy (standard form ref:beg-end, or '*' for reads with no 
      reference)
    inputBinding:
      position: 2
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Specify that input is in FASTA format
    inputBinding:
      position: 103
      prefix: --fasta-input
  - id: regions_bed_file
    type:
      - 'null'
      - File
    doc: Output only reads overlapping one of regions from the BED file
    inputBinding:
      position: 103
      prefix: --regions
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output BAM or FASTA filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
