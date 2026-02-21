cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbls-factors-viz
label: mtbls-factors-viz
doc: "A tool for visualizing factors in MetaboLights studies. (Note: The provided
  help text contains system error logs regarding container execution and does not
  list specific command-line arguments).\n\nTool homepage: https://github.com/phnmnl/container-mtbls-factors-viz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mtbls-factors-viz:phenomenal-v0.5_cv0.4.2.19
stdout: mtbls-factors-viz.out
