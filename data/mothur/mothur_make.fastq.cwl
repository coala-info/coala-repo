cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_make.fastq
doc: "mothur v.1.48.5\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: batch_file
    type: File
    doc: Batch file for mothur commands
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_make.fastq.out
