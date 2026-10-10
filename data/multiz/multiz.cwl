cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiz
label: multiz
doc: "multiz: aligning two files of alignment blocks where top rows are always the
  reference, reference in both files cannot have duplicates. Usage: multiz [R=?] [M=?]
  file1 file2 v? [out1 out2] [nohead] [all]. The alignment goes to standard output.\n\nTool
  homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: radius
    type:
      - 'null'
      - int
    doc: R, radius in dynamic programming (default 30).
    inputBinding:
      position: 1
      prefix: R=
      separate: false
  - id: minimum_output_width
    type:
      - 'null'
      - int
    doc: M, minimum output width (default 1).
    inputBinding:
      position: 2
      prefix: M=
      separate: false
  - id: file1
    type: File
    doc: First alignment block file (MAF)
    inputBinding:
      position: 3
  - id: file2
    type: File
    doc: Second alignment block file (MAF)
    inputBinding:
      position: 4
  - id: v
    type: int
    doc: The v argument, 0 or 1. It selects the way the alignment step is used.
    inputBinding:
      position: 5
  - id: out1_path
    type:
      - 'null'
      - string
    doc: File name for collecting unused input from file1 (give together with out2_path)
    inputBinding:
      position: 6
  - id: out2_path
    type:
      - 'null'
      - string
    doc: File name for collecting unused input from file2 (give together with out1_path)
    inputBinding:
      position: 7
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output the MAF header (nohead)
    inputBinding:
      position: 8
      valueFrom: "$(self ? 'nohead' : null)"
  - id: all_blocks
    type:
      - 'null'
      - boolean
    doc: Output all blocks, including single-row blocks (all)
    inputBinding:
      position: 9
      valueFrom: "$(self ? 'all' : null)"
outputs:
  - id: alignment
    type: stdout
    doc: Merged MAF alignment (standard output)
  - id: out1
    type:
      - 'null'
      - File
    doc: Unused input from file1
    outputBinding:
      glob: $(inputs.out1_path)
  - id: out2
    type:
      - 'null'
      - File
    doc: Unused input from file2
    outputBinding:
      glob: $(inputs.out2_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: multiz.maf
