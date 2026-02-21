cwlVersion: v1.2
class: CommandLineTool
baseCommand: idr
label: idr-py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding a container
  runtime (Singularity/Apptainer) failing to build a SIF format image due to insufficient
  disk space.\n\nTool homepage: https://github.com/IDR/idr-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idr-py:0.4.2--py_0
stdout: idr-py.out
