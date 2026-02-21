cwlVersion: v1.2
class: CommandLineTool
baseCommand: eval
label: eval
doc: "The provided text does not contain help information for the 'eval' tool; it
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container due to lack of disk space.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval.out
