cwlVersion: v1.2
class: CommandLineTool
baseCommand: deltamsi
label: deltamsi
doc: "The provided text does not contain a description of the tool or its usage information,
  as it appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/RADar-AZDelta/DeltaMSI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deltamsi:1.0.1--pyh7cba7a3_0
stdout: deltamsi.out
