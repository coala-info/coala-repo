cwlVersion: v1.2
class: CommandLineTool
baseCommand: isodate
label: isodate
doc: "The provided text does not contain help information for the tool 'isodate'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to insufficient disk space.\n\nTool homepage:
  https://github.com/gweis/isodate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isodate:0.5.4--py36_0
stdout: isodate.out
