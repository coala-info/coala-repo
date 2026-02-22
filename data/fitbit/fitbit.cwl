cwlVersion: v1.2
class: CommandLineTool
baseCommand: fitbit
label: fitbit
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than the help text for the 'fitbit'
  tool itself. As a result, no command-line arguments or tool descriptions could be
  extracted.\n\nTool homepage: https://github.com/arpanghosh8453/fitbit-grafana"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fitbit:v0.3.0-4-deb-py2_cv1
stdout: fitbit.out
