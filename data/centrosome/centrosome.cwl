cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrosome
label: centrosome
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It appears to be a log of a failed container build process
  (Apptainer/Singularity) due to insufficient disk space.\n\nTool homepage: https://github.com/CellProfiler/centrosome"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrosome:1.3.3--py312h2973bf2_0
stdout: centrosome.out
