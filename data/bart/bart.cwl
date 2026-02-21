cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart
label: bart
doc: "The provided text does not contain help information for the 'bart' tool; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to extract the tool's image due to insufficient disk space.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bart:0.1.2--pyhdfd78af_0
stdout: bart.out
