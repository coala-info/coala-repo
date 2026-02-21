cwlVersion: v1.2
class: CommandLineTool
baseCommand: bg
label: bg
doc: "The provided text does not contain help information or usage instructions for
  the tool 'bg'. It appears to be a fatal error log from a container build process
  (Apptainer/Singularity) indicating a 'no space left on device' failure.\n\nTool
  homepage: https://github.com/aganezov/bg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bg:1.10--pyh5e36f6f_0
stdout: bg.out
