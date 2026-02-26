cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToWig
label: ucsc-qactowig_qacToWig
doc: "convert from compressed quality score format to wiggle format.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_qac
    type: File
    doc: Input compressed quality score file
    inputBinding:
      position: 1
  - id: out_file_or_dir
    type: string
    doc: Output file or directory
    inputBinding:
      position: 2
  - id: fixed
    type:
      - 'null'
      - boolean
    doc: output single file with wig headers and fixed step size
    inputBinding:
      position: 103
  - id: name
    type:
      - 'null'
      - string
    doc: restrict output to just this sequence name
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactowig:482--h0b57e2e_0
stdout: ucsc-qactowig_qacToWig.out
