cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmsi
label: fmsi
doc: "The provided text does not contain help information for the tool 'fmsi'. It
  contains runtime error logs from a container engine (Apptainer/Singularity) indicating
  a failure to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi.out
