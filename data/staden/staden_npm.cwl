cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden_npm
label: staden_npm
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of container runtime (Apptainer/Singularity) error logs encountered
  while attempting to fetch the tool image.\n\nTool homepage: https://github.com/oshikiri/staden-outliner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden:v2.0.0b11-4-deb_cv1
stdout: staden_npm.out
