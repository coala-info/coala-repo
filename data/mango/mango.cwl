cwlVersion: v1.2
class: CommandLineTool
baseCommand: mango
label: mango
doc: "The provided text does not contain help information for the tool 'mango'. It
  consists of error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/bdgenomics/mango"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mango:0.0.5--py_0
stdout: mango.out
