cwlVersion: v1.2
class: CommandLineTool
baseCommand: leptonica
label: leptonica
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Apptainer/Singularity)
  failing to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/DanBloomberg/leptonica"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leptonica:1.73--1
stdout: leptonica.out
