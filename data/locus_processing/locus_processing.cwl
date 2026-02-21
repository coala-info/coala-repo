cwlVersion: v1.2
class: CommandLineTool
baseCommand: locus_processing
label: locus_processing
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  or build the image due to insufficient disk space.\n\nTool homepage: https://github.com/LUMC/locus_processing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locus_processing:0.0.4--py_0
stdout: locus_processing.out
