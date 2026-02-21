cwlVersion: v1.2
class: CommandLineTool
baseCommand: icescreen
label: icescreen
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://forgemia.inra.fr/ices_imes_analysis/icescreen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icescreen:1.3.3--py312h7e72e81_0
stdout: icescreen.out
