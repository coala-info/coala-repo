cwlVersion: v1.2
class: CommandLineTool
baseCommand: miidl
label: miidl
doc: "The provided text does not contain help information or usage instructions for
  the tool 'miidl'. It contains error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/chunribu/miidl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miidl:0.0.5--pyh5e36f6f_0
stdout: miidl.out
