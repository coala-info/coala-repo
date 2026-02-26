cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtk
  - sub
label: bedtk_sub
doc: "Subtracts regions from another set of regions.\n\nTool homepage: https://github.com/lh3/bedtk"
inputs:
  - id: minuend_bed
    type: File
    doc: The BED file from which to subtract regions.
    inputBinding:
      position: 1
  - id: subtrahend_bed
    type: File
    doc: <subtrahend.bed> is loaded into memory.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk_sub.out
