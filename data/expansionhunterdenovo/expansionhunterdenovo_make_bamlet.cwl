cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - make-bamlet.py
label: expansionhunterdenovo_make_bamlet
doc: "A script to generate BAMlets: reads from a region (extended by 2000 bp on each side) plus their mates\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: region
    type: string
    doc: Region from which to extract reads (chr:start-end)
    inputBinding:
      position: 101
      prefix: --region
  - id: bamlet
    type: string
    doc: Output BAMlet
    inputBinding:
      position: 102
      prefix: --bamlet
outputs:
  - id: bamlet_out
    type:
      - 'null'
      - File
    doc: The BAMlet with the extracted reads
    outputBinding:
      glob: $(inputs.bamlet)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
