cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_project
label: multiz_maf_project
doc: "maf_project: extract maf-file entries that name a given reference sequence. Usage: maf_project file.maf reference [from to] [filename-for-other-mafs] [nohead]. The projected alignment goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: reference
    type: string
    doc: Name of the reference sequence (source name in the MAF)
    inputBinding:
      position: 2
  - id: from_pos
    type:
      - 'null'
      - int
    doc: Start of the interval on the reference (give together with to_pos)
    inputBinding:
      position: 3
  - id: to_pos
    type:
      - 'null'
      - int
    doc: End of the interval on the reference (give together with from_pos)
    inputBinding:
      position: 4
  - id: other_mafs_path
    type:
      - 'null'
      - string
    doc: File name for the alignments that do not name the reference
    inputBinding:
      position: 5
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output the MAF header (nohead)
    inputBinding:
      position: 6
      valueFrom: "$(self ? \"nohead\" : null)"
outputs:
  - id: projected
    type: stdout
    doc: Projected MAF alignment (standard output)
  - id: other_mafs
    type:
      - 'null'
      - File
    doc: Alignments that do not name the reference
    outputBinding:
      glob: $(inputs.other_mafs_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf_project.maf
