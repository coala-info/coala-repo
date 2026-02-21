cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shapeshifter-cli
  - expressionable
label: shapeshifter-cli_expressionable
doc: "The provided text contains container runtime error logs (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space. It does
  not contain the help text or usage information for the 'shapeshifter-cli expressionable'
  command.\n\nTool homepage: https://github.com/srp33/ShapeShifter-CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0
stdout: shapeshifter-cli_expressionable.out
