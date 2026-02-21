cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher
label: philosopher
doc: "Philosopher: a complete toolkit for proteomics data analysis\n\nTool homepage:
  https://github.com/Nesvilab/philosopher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher.out
