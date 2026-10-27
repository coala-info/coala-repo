cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Vmatchtrans.pl
label: vmatch_vmatchtrans
doc: "Transform a Vmatch match file into the chainer, open or posdist format.

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: format
    type: string
    doc: "output format: chainer, open or posdist"
    inputBinding:
      position: 1
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "match file written by vmatch"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vmatchtrans.out
