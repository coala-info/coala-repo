cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools overlap
label: dmtools_overlap
doc: "Calculate overlap between two DM files.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: 'bed file for view, format: chrom start end [strand].'
    inputBinding:
      position: 101
      prefix: --bed
  - id: dmfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: input DM files, seperated by comma. This is no need if you provide -i 
      and -i2.
    inputBinding:
      position: 101
      prefix: --dmfiles
  - id: meth1_dm
    type:
      type: array
      items: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
  - id: meth2_dm
    type:
      type: array
      items: File
    doc: input DM file2
    inputBinding:
      position: 101
      prefix: -i2
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: region for view, can be seperated by space. chr1:1-2900 chr2:1-200
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_overlap.out
