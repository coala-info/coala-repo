cwlVersion: v1.2
class: CommandLineTool
baseCommand: gb-io
label: gb-io
doc: "The provided text does not contain help information or usage instructions for
  the tool 'gb-io'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF format image due to insufficient disk space.\n
  \nTool homepage: https://github.com/althonos/gb-io.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb-io:0.3.8--py311h5e00ca1_0
stdout: gb-io.out
