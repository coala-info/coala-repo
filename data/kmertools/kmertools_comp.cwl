cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmertools
  - comp
label: kmertools_comp
doc: "Generate sequence composition based features\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: command
    type: string
    doc: Command to run (oligo, cgr, help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
stdout: kmertools_comp.out
