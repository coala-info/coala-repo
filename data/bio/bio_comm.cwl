cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_comm
doc: "A better 'comm' command. Prints elements common from columns from two files.\n\
  \nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: file1
    type: File
    doc: input file 1
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: input file 2
    inputBinding:
      position: 2
  - id: col1
    type:
      - 'null'
      - int
    doc: column index for file 1
    inputBinding:
      position: 103
      prefix: --col1
  - id: col2
    type:
      - 'null'
      - int
    doc: column index for file 2
    inputBinding:
      position: 103
      prefix: --col2
  - id: tab
    type:
      - 'null'
      - boolean
    doc: tab delimited (default is csv)
    inputBinding:
      position: 103
      prefix: --tab
  - id: union
    type:
      - 'null'
      - boolean
    doc: prints elements present in both files
    inputBinding:
      position: 103
      prefix: --union
  - id: uniq1
    type:
      - 'null'
      - boolean
    doc: prints elements unique to file 1
    inputBinding:
      position: 103
      prefix: --uniq1
  - id: uniq2
    type:
      - 'null'
      - boolean
    doc: prints elements unique to file 2
    inputBinding:
      position: 103
      prefix: --uniq2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_comm.out
