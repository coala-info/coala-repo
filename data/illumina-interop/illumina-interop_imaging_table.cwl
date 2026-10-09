cwlVersion: v1.2
class: CommandLineTool
baseCommand: interop_imaging_table
label: illumina-interop_imaging_table
doc: "Table of per-tile, per-cycle imaging metrics for one or more run folders\n\nTool homepage: http://illumina.github.io/interop/index.html"
inputs:
  - id: run_folders
    type:
      type: array
      items: Directory
    doc: Paths to one or more run folders
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
stdout: interop_imaging_table.out
