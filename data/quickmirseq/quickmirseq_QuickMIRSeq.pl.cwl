cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl /usr/local/bin/QuickMIRSeq.pl
label: quickmirseq_QuickMIRSeq.pl
doc: "QuickMIRSeq.pl\n\nTool homepage: https://sourceforge.net/projects/quickmirseq/"
inputs:
  - id: id_file
    type: File
    doc: ID file
    inputBinding:
      position: 1
  - id: configuration_file
    type: File
    doc: Configuration file
    inputBinding:
      position: 2
  - id: chunk
    type:
      - 'null'
      - string
    doc: Optional chunk
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3
stdout: quickmirseq_QuickMIRSeq.pl.out
