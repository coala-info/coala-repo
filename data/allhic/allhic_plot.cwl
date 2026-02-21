cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - plot
label: allhic_plot
doc: "Plot BAM and tour files for ALLHIC\n\nTool homepage: https://github.com/tanghaibao/allhic"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: tour_file
    type: File
    doc: Input tour file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_plot.out
