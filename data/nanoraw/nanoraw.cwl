cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw
label: nanoraw
doc: "The provided text contains system error messages related to a container runtime
  (Apptainer/Singularity) and does not contain help documentation for the nanoraw
  tool.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw.out
