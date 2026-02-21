cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmb_pyTMB.py
label: tmb_pyTMB.py
doc: "Tumor Mutational Burden (TMB) calculation tool. (Note: The provided text contains
  container runtime error logs rather than the tool's help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/bioinfo-pf-curie/TMB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmb:1.5.0--pyhdfd78af_1
stdout: tmb_pyTMB.py.out
