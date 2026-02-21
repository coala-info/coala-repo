cwlVersion: v1.2
class: CommandLineTool
baseCommand: newt
label: newt
doc: "The provided text does not contain help information or usage instructions for
  the tool 'newt'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/JamesNK/Newtonsoft.Json"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newt:0.52.18--py36_2
stdout: newt.out
