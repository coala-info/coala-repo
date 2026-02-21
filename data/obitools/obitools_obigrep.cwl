cwlVersion: v1.2
class: CommandLineTool
baseCommand: obigrep
label: obitools_obigrep
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Apptainer/Singularity)
  failing to build an image due to lack of disk space.\n\nTool homepage: http://metabarcoding.org/obitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools:1.2.13--py27h516909a_0
stdout: obitools_obigrep.out
