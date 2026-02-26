cwlVersion: v1.2
class: CommandLineTool
baseCommand: hotspot3d
label: hotspot3d_Analysis
doc: "3D mutation proximity analysis program.\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run. Options include: drugport, uppro, prep, calroi, statis,
      anno, trans, cosmic, prior, main, search, cluster, sigclus, summary, visual'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
stdout: hotspot3d_Analysis.out
