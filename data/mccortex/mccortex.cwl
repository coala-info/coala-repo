cwlVersion: v1.2
class: CommandLineTool
baseCommand: mccortex
label: mccortex
doc: "The provided text does not contain help information or usage instructions for
  mccortex. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex.out
