cwlVersion: v1.2
class: CommandLineTool
baseCommand: psi-cd-hit
label: cd-hit_psi-cd-hit
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build or extract a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit_psi-cd-hit.out
