cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge
label: strainge
doc: "The provided text does not contain help information or usage instructions for
  the 'strainge' tool. It appears to be a log of a failed container build/fetch process
  using Apptainer/Singularity.\n\nTool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py310hd22044e_1
stdout: strainge.out
