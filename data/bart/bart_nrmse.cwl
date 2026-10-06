cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, nrmse]
requirements:
  - class: InlineJavascriptRequirement
label: bart_nrmse
doc: "Output normalized root mean square error (NRMSE), i.e. norm(input - ref) / norm(ref)\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: reference
    type: File
    doc: reference
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: automatic_scaling
    type:
      - 'null'
      - boolean
    doc: automatic (complex) scaling
    inputBinding:
      position: 1
      prefix: -s
  - id: eps
    type:
      - 'null'
      - float
    doc: compare to eps
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_nrmse.out
