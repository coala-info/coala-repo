cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToWig
label: ucsc-qactowig_qacToWig
doc: "Convert from compressed quality score format to wiggle format. If neither
  -name nor -fixed is used, outFileOrDir is a directory which will be created if it
  does not already exist. If -name and/or -fixed is used, outFileOrDir is a file (or
  \"stdout\").\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_qac
    type: File
    doc: Input compressed quality score file (.qac).
    inputBinding:
      position: 10
  - id: out_file_or_dir
    type: string
    doc: Output directory (default mode, one wig file per sequence) or output file
      (when -name and/or -fixed is used).
    inputBinding:
      position: 11
  - id: fixed
    type:
      - 'null'
      - boolean
    doc: Output single file with wig headers and fixed step size.
    inputBinding:
      position: 1
      prefix: -fixed
  - id: name
    type:
      - 'null'
      - string
    doc: Restrict output to just this sequence name.
    inputBinding:
      position: 2
      prefix: -name=
      separate: false
outputs:
  - id: out_wig
    type:
      - File
      - Directory
    doc: Output wiggle file, or directory of wiggle files in the default mode.
    outputBinding:
      glob: $(inputs.out_file_or_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactowig:482--h0b57e2e_0
