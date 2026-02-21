cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-est
label: cd-hit_cd-hit-est
doc: "The provided text does not contain help information for cd-hit-est; it contains
  system error logs regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit_cd-hit-est.out
