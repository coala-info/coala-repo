cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-dup
label: cd-hit_cd-hit-dup
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit_cd-hit-dup.out
