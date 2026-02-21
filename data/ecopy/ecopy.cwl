cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecopy
label: ecopy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the 'ecopy' tool.\n
  \nTool homepage: https://github.com/Auerilas/ecopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ecopy:0.1.2.2--py36_0
stdout: ecopy.out
