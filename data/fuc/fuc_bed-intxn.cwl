cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - bed-intxn
label: fuc_bed-intxn
doc: "Find the intersection of BED files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bed_files
    type:
      type: array
      items: File
    doc: Input BED files.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bed-intxn.out
