cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Genemark
label: bioperl-run_Genemark
doc: "The provided text is an error log related to a container runtime failure (no
  space left on device) and does not contain help documentation or argument definitions
  for the tool.\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Genemark.out
