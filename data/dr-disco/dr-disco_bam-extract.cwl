cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dr-disco
  - bam-extract
label: dr-disco_bam-extract
doc: "Extracts reads from BAM files that overlap with specified regions.\n\nTool homepage:
  https://github.com/yhoogstrate/dr-disco"
inputs:
  - id: region1
    type: string
    doc: The first region to extract reads from.
    inputBinding:
      position: 1
  - id: region2
    type: string
    doc: The second region to extract reads from.
    inputBinding:
      position: 2
  - id: bam_input_file
    type: File
    doc: The input BAM file.
    inputBinding:
      position: 3
  - id: restrict_to_targeted_chromosomes
    type:
      - 'null'
      - boolean
    doc: Excludes reads of which a piece was aligned to other chromosomes than 
      requested by the regions.
    inputBinding:
      position: 104
      prefix: --restrict-to-targeted-chromosomes
outputs:
  - id: bam_output_file
    type: File
    doc: The output BAM file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
