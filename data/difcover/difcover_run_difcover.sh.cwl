cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_run_difcover.sh
label: difcover_run_difcover.sh
doc: "Stage 1\n\nTool homepage: https://github.com/timnat/DifCover"
inputs:
  - id: sample1_sample2_unionbedcv
    type: File
    doc: sample1_sample2.unionbedcv
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_run_difcover.sh.out
