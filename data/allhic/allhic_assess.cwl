cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - assess
label: allhic_assess
doc: "Assess Hi-C data using BAM and BED files\n\nTool homepage: https://github.com/tanghaibao/allhic"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: Input BED file
    inputBinding:
      position: 2
  - id: chromosome
    type: string
    doc: Chromosome name (e.g., chr1)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_assess.out
