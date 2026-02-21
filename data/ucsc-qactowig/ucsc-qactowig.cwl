cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToWig
label: ucsc-qactowig
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactowig:482--h0b57e2e_0
stdout: ucsc-qactowig.out
