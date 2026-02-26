cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_merge.files
doc: "mothur v.1.48.5\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: merge_files
    type: File
    doc: Batch file containing commands to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_merge.files.out
