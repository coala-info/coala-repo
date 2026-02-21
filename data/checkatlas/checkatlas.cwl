cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkatlas
label: checkatlas
doc: "A tool for quality control and checking of single-cell datasets. (Note: The
  provided text is a container build error log and does not contain CLI help information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://checkatlas.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkatlas:0.7.1--pyhdfd78af_0
stdout: checkatlas.out
