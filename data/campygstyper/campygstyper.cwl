cwlVersion: v1.2
class: CommandLineTool
baseCommand: campygstyper
label: campygstyper
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/LanLab/campygstyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campygstyper:0.1.1--pyhdfd78af_0
stdout: campygstyper.out
