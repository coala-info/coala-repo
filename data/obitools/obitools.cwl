cwlVersion: v1.2
class: CommandLineTool
baseCommand: obitools
label: obitools
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools.out
