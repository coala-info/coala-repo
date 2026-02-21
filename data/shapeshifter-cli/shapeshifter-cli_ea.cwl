cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeshifter-cli
label: shapeshifter-cli_ea
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/srp33/ShapeShifter-CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0
stdout: shapeshifter-cli_ea.out
