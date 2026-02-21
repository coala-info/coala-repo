cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctsim-help
label: ctsim-help
doc: The provided text appears to be a log of a failed container build process (Apptainer/Singularity)
  rather than the help text for the tool itself. No command-line arguments or usage
  instructions were found in the input.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctsim-help:v6.0.2-2-deb_cv1
stdout: ctsim-help.out
