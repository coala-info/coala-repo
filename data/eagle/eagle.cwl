cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle
label: eagle
doc: "The provided text does not contain help information or usage instructions for
  the tool 'eagle'. It contains system log messages and a fatal error related to a
  container runtime (Apptainer/Singularity) failing to pull the tool's image due to
  insufficient disk space.\n\nTool homepage: https://bitbucket.org/christopherschroeder/eagle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
stdout: eagle.out
