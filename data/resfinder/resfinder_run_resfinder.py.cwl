cwlVersion: v1.2
class: CommandLineTool
baseCommand: resfinder_run_resfinder.py
label: resfinder_run_resfinder.py
doc: "ResFinder identifies acquired antimicrobial resistance genes in total or partial
  sequenced isolates of bacteria. (Note: The provided text contains container runtime
  logs and error messages rather than tool help documentation.)\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/resfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resfinder:4.7.2--pyhdfd78af_0
stdout: resfinder_run_resfinder.py.out
