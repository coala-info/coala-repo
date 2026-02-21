cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmlst_pmlst.py
label: pmlst_pmlst.py
doc: "The provided text does not contain help information for pmlst_pmlst.py; it is
  a log of a container build failure.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/pmlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmlst:2.0.3--hdfd78af_0
stdout: pmlst_pmlst.py.out
