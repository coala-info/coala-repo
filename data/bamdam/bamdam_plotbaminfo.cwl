cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamdam
  - plotbaminfo
label: bamdam_plotbaminfo
doc: "Generate plots from BAM file information.\n\nTool homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: in_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bam file(s)
    inputBinding:
      position: 101
      prefix: --in_bam
  - id: in_bam_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing input bams, one per line
    inputBinding:
      position: 101
      prefix: --in_bam_list
outputs:
  - id: outplot
    type:
      - 'null'
      - File
    doc: Filename for the output plot, ending in .png or .pdf
    outputBinding:
      glob: $(inputs.outplot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
