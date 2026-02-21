cwlVersion: v1.2
class: CommandLineTool
baseCommand: novoplasty
label: novoplasty
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container environment (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/ndierckx/NOVOPlasty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoplasty:4.3.5--pl5321hdfd78af_0
stdout: novoplasty.out
