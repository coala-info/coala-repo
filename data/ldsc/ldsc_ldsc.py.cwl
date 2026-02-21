cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldsc_ldsc.py
label: ldsc_ldsc.py
doc: "LD Score Regression (LDSC). Note: The provided text is an error log indicating
  a container build failure ('no space left on device') and does not contain the actual
  help documentation or argument definitions.\n\nTool homepage: https://github.com/bulik/ldsc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldsc:1.0.1--py_0
stdout: ldsc_ldsc.py.out
