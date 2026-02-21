cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_measure_map.py
label: frc_measure_map.py
doc: "A tool for calculating Fourier Ring Correlation (FRC) measure maps. Note: The
  provided help text contains only system error messages regarding container execution
  and does not list specific arguments.\n\nTool homepage: https://github.com/lucasjinreal/keras_frcnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_measure_map.py.out
