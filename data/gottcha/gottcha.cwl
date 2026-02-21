cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha
label: gottcha
doc: "The provided text does not contain help information or usage instructions for
  the tool 'gottcha'. It appears to be a system error log from a container runtime
  (Singularity/Apptainer) indicating a failure to build or run the container due to
  insufficient disk space.\n\nTool homepage: https://github.com/poeli/GOTTCHA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha.out
