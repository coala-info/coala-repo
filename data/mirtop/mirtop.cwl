cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirtop
label: mirtop
doc: "The provided text does not contain help information or usage instructions; it
  is a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a 'no space left on device' error during image conversion.\n\nTool homepage: http://github.com/mirtop/mirtop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirtop:0.4.30--pyh7e72e81_0
stdout: mirtop.out
