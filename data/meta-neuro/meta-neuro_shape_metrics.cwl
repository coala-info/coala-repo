cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-neuro_shape_metrics
label: meta-neuro_shape_metrics
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message indicating a failure to build a container
  image due to lack of disk space.\n\nTool homepage: https://github.com/bagari/meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
stdout: meta-neuro_shape_metrics.out
