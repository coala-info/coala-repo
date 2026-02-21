cwlVersion: v1.2
class: CommandLineTool
baseCommand: drug2cell
label: drug2cell
doc: "A tool for drug-target analysis in single-cell data. (Note: The provided text
  is a container runtime error message and does not contain help documentation or
  argument definitions.)\n\nTool homepage: https://github.com/teichlab/drug2cell/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drug2cell:0.1.2--pyhdfd78af_0
stdout: drug2cell.out
