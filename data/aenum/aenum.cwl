cwlVersion: v1.2
class: CommandLineTool
baseCommand: aenum
label: aenum
doc: "The provided text does not contain help information for the tool 'aenum'. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build or fetch the container image due to insufficient disk space.\n\nTool homepage:
  https://bitbucket.org/stoneleaf/aenum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aenum:2.0.8--py35_0
stdout: aenum.out
