cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-2d
label: cd-hit_cd-hit-2d
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit_cd-hit-2d.out
