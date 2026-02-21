cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit
label: cd-hit
doc: "The provided text does not contain help information for cd-hit; it is a fatal
  error log from a container runtime (Apptainer/Singularity) indicating a 'no space
  left on device' error during image extraction.\n\nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
stdout: cd-hit.out
