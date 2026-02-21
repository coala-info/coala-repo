cwlVersion: v1.2
class: CommandLineTool
baseCommand: nseg
label: nseg
doc: "The provided text does not contain help information for the tool 'nseg'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/jebrosen/nseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nseg:1.0.1--h7b50bb2_6
stdout: nseg.out
