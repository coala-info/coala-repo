cwlVersion: v1.2
class: CommandLineTool
baseCommand: maffilter
label: maffilter
doc: "MAF Filter\n\nTool homepage: https://github.com/jydu/maffilter"
inputs:
  - id: name1
    type:
      - 'null'
      - string
    doc: name1=value1
    inputBinding:
      position: 1
  - id: name2
    type:
      - 'null'
      - string
    doc: name2=value2
    inputBinding:
      position: 2
  - id: option_file
    type:
      - 'null'
      - File
    doc: param=option_file
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maffilter:v1.3.1dfsg-1b1-deb_cv1
stdout: maffilter.out
