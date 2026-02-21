cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpralib
label: mpralib
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build a SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/kircherlab/MPRAlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpralib:0.9.1--pyhdfd78af_0
stdout: mpralib.out
