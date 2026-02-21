cwlVersion: v1.2
class: CommandLineTool
baseCommand: iptkl
label: iptkl
doc: "The provided text does not contain help information for the tool 'iptkl'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/ikmb/iptoolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iptkl:0.6.8--pyh5e36f6f_0
stdout: iptkl.out
