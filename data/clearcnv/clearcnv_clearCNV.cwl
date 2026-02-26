cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearCNV
label: clearcnv_clearCNV
doc: "clearCNV can compute matchscores, CNV-calls and visualizations.\n\nTool homepage:
  https://github.com/bihealth/clear-cnv"
inputs:
  - id: subcommand
    type: string
    doc: 'Available subcommands: matchscores, cnv_calling, visualize, merge_bed, prepare_reassignment,
      coverage, merge_coverages, annotations, workflow_cnv_calling, workflow_reassignment,
      visualize_reassignment'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
stdout: clearcnv_clearCNV.out
