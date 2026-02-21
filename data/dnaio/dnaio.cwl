cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaio
label: dnaio
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build a SIF image due to lack of disk space.\n\nTool homepage: https://github.com/marcelm/dnaio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaio:1.2.3--py313h031d066_0
stdout: dnaio.out
