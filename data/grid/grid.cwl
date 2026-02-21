cwlVersion: v1.2
class: CommandLineTool
baseCommand: grid
label: grid
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'grid'
  tool.\n\nTool homepage: https://github.com/ohlab/GRiD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grid:1.3--0
stdout: grid.out
