cwlVersion: v1.2
class: CommandLineTool
baseCommand: trnanalysis
label: trnanalysis
doc: "A tool for tRNA analysis. (Note: The provided text is a container build error
  log and does not contain specific CLI usage or argument information.)\n\nTool homepage:
  https://trnanalysis.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trnanalysis:0.1.10--py_0
stdout: trnanalysis.out
