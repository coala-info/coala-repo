cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_kruskal.wallis
doc: "Performs Kruskal-Wallis test on the data.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: batch_file
    type: File
    doc: Batch file containing commands for kruskal.wallis
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_kruskal.wallis.out
