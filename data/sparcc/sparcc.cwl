cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparcc
label: sparcc
doc: "The provided text does not contain help information for the tool 'sparcc'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch the tool's image.\n\nTool homepage: https://bitbucket.org/yonatanf/sparcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparcc:0.1.0--0
stdout: sparcc.out
